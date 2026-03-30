#!/usr/bin/env python3

import argparse

import configparser
from pathlib import Path
import re
import sys

from dataclasses import dataclass


class ProfileAlreadyExistsError(Exception):
    def __init__(self, message="Profile already exists"):
        self.message = message
        super().__init__(self.message)


class ProfileDoesNotExistsError(Exception):
    def __init__(self, message="Profile does not exist"):
        self.message = message
        super().__init__(self.message)


@dataclass
class AddProfileInfo:
    name: str
    account_id: str
    role_name: str
    region: str


@dataclass
class RemoveProfileInfo:
    name: str


def add_profile(info: AddProfileInfo):
    config = load_aws_config()
    profiles = profile_names(config)
    if info.name in profiles:
        raise ProfileAlreadyExistsError
    config[f"profile {info.name}"] = {}
    p = config[f"profile {info.name}"]
    p["sso_session"] = "uoregon"
    p["sso_account_id"] = info.account_id
    p["sso_role_name"] = info.role_name
    p["region"] = info.region
    save_aws_config(config)


def remove_profile(info: RemoveProfileInfo):
    config = load_aws_config()
    profiles = profile_names(config)
    if info.name not in profiles:
        raise ProfileDoesNotExistsError
    del config[f"profile {info.name}"]
    save_aws_config(config)


def list_profiles():
    config = load_aws_config()
    profiles = profile_names(config)
    for name in profiles:
        print(name)


def profile_names(config: configparser.ConfigParser) -> list[str]:
    profiles = []
    for section in config.sections():
        if section.startswith("profile"):
            profiles.append(section.replace("profile ", ""))
    return profiles


def process_add_args(
    name: str,
    account_id: str,
    role_name: str,
    region: str,
) -> AddProfileInfo:
    if not account_id:
        # try to parse account id from name
        matches = re.search(r"(\d{12})", name)
        if matches:
            account_id = matches[1]
        else:
            raise Exception("Account ID not provided and not found in profile name")
    if not role_name:
        # see if the role name is appended to the end
        matches = re.search(r"_(\w+)$", name)
        if matches:
            role_name = matches[1]
        else:
            role_name = "Administrator"
    if not region:
        region = "us-west-2"

    return AddProfileInfo(
        name=name, account_id=account_id, role_name=role_name, region=region
    )


def get_default_aws_config_path() -> str:
    try:
        path = Path.home() / ".aws" / "config"
    except Exception as e:
        raise Exception(f"failed to build path for aws config: {e}")
    return str(path)


def load_aws_config() -> configparser.ConfigParser:
    try:
        path = get_default_aws_config_path()
    except Exception as e:
        raise Exception(f"failed to build path for aws config: {e}")
    try:
        config = configparser.ConfigParser()
        config.read(path)
    except Exception as e:
        raise Exception(f"failed to read aws config at path '{path}': {e}")
    return config


def save_aws_config(config: configparser.ConfigParser):
    try:
        path = get_default_aws_config_path()
    except Exception as e:
        raise Exception(f"failed to build path for aws config: {e}")
    try:
        with open(path, "w") as configfile:
            config.write(configfile)
    except Exception as e:
        raise Exception(f"failed to write aws config file: {e}")


def main():
    parser = argparse.ArgumentParser(description="AWS Profile Manager")
    subparsers = parser.add_subparsers(dest="command", required=True)

    add_parser = subparsers.add_parser("add", help="Add a profile")
    add_parser.add_argument("profile_name", help="Profile name")
    add_parser.add_argument("--account-id", help="Account ID")
    add_parser.add_argument("--role-name", help="Role name")
    add_parser.add_argument("--region", help="Region")

    remove_parser = subparsers.add_parser("remove", help="Remove a profile")
    remove_parser.add_argument("profile_name", help="Profile name")

    list_parser = subparsers.add_parser("list", help="List profiles")

    args = parser.parse_args()

    if args.command == "add":
        try:
            info = process_add_args(
                name=args.profile_name,
                account_id=args.account_id,
                role_name=args.role_name,
                region=args.region,
            )
            add_profile(info)
        except Exception as e:
            print(f"Failed to add profile: {e}", file=sys.stderr)
            exit(1)

    if args.command == "remove":
        try:
            info = RemoveProfileInfo(
                name=args.profile_name,
            )
            remove_profile(info)
        except Exception as e:
            print(f"Failed to remove profile: {e}", file=sys.stderr)
            exit(1)

    if args.command == "list":
        try:
            list_profiles()
        except Exception as e:
            print(f"Failed to list profiles: {e}", file=sys.stderr)
            exit(1)


if __name__ == "__main__":
    main()
