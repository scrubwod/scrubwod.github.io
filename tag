#!/usr/bin/env python3
"""
Helper to determine the tags that I've been using.

Usage:

    tags

Requires python-frontmatter:

    python3 -m pip install python-frontmatter

"""
import argparse
import frontmatter
import os

OUTPUT_DIR = "./_posts"

this_dir = os.path.dirname(__file__)
post_dir = os.path.join(this_dir, OUTPUT_DIR)


def main():
    # Parse arguments
    parser = argparse.ArgumentParser(
        description="Create new post"
    )
    parser.add_argument(
        "--extended", "-e",
        help="Display posts associated with given tag.",
        action="store_true"
    )
    args = vars(parser.parse_args())

    tags = {}
    for post_filename in os.listdir(post_dir):
        with open(os.path.join(post_dir, post_filename)) as fp:
            post = frontmatter.load(fp)
            for tag in post.get('tags', []):
                tags.setdefault(tag, []).append(
                    (
                        post.get('date', '0000-00-00'),
                        post.get('title', post_filename)
                    )
                )

    for tag, posts in sorted(tags.items()):
        print(tag)
        if args['extended']:
            print(
                '\n'.join('  - "{}"'.format(post) for date, post in sorted(posts))
            )


if __name__ == "__main__":
    main()

