import json
from requests import post, exceptions
from sys import argv
from re import compile, match

# Swiftype API being used by the ansible documentation page
# for the latest ansible version (exposed for testing)
url = "https://search-api.swiftype.com/api/v1/public/installs/yABGvz2N8PwcwBxyfzUc/search.json"

# Required fields in the API response (exposed for testing)
fields = ["title", "url"]


def parse_title(title: str) -> (str, str):
    """
    Parse ansible swiftype API search response using regular expressions
    """
    # Characters that are valid for title and subtitles
    valid_class = r'[a-zA-Z0-9 \.\,\_\-/|#\(\)\[\]]+'
    # The API returns two types of module descriptions
    # * Containing the title followed by \u2014 and a non-descriptive suffix
    # * Containing the title followed by \u2013 and a description
    pattern_simple = compile(
        f'(?P<title>{valid_class}) \u2014 (?P<desc>{valid_class})')
    pattern_full = compile(
        f'(?P<title>{valid_class}) \u2013 (?P<desc>{valid_class}) \u2014')
    # Check which pattern matches and use the capture groups to return
    # title and subtitle
    if match(pattern_full, title):
        m = pattern_full.search(title)
        return m.group("title"), m.group("desc")
    elif match(pattern_simple, title):
        m = pattern_simple.search(title)
        return m.group("title"), m.group("desc")
    else:
        # Return only the title if neither pattern matches
        # just to be safe..
        return title, ""


def query_api(url: str, search_string: str) -> [{}]:
    """
    Query ansible swiftype API and deserialize the JSON response
    """
    try:
        response = post(url, data={'q': search_string}).json()
        # Check if the response was valid json, but contains an error
        if "error" in response:
            # Raise a ValueError to simplify error handling
            raise ValueError(response["error"])
    except (exceptions.ConnectionError, ValueError) as err:
        # Return the error message encapsulated in a dict
        return [{"error": str(err)}]
    else:
        # Only return the first result page
        return response["records"]["page"]


def parse_results(results: {}) -> []:
    """
    Transform the results from the ansible swiftype API to
    alfred script filter items
    """
    items = []
    for item in results:
        if "error" in item:
            items.append({"title": "Error",
                          "subtitle": item["error"],
                          "valid": False})
        # Check if the required fields in the payload
        if all(field in item.keys() for field in fields):
            # Parse the title field and extact title and subtitle
            title, subtitle = parse_title(item["title"])
            # Render an alfred script filter item for the result
            # and append it to the result list items
            items.append({"title": title,
                          "subtitle": subtitle,
                          "arg": item["url"],
                          "valid": True})
    return items


if __name__ == "__main__":
    # Initialise result list
    items = []

    # Only query API if a search string is provided
    if (len(argv) > 1):
        # Combine query params
        query = " ".join(argv[1:])
        # Query the api and parse the results
        items = parse_results(query_api(url, query))

    # Print an alfred script filter response as a json dictionary
    print(json.dumps({"items": items}))

