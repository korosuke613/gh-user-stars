#!/usr/bin/env bash

list=""
endCursor=""
is_end="true"

call_star_api(){
  # shellcheck disable=SC2016
  gh api graphql -F first="$1" -F endCursor="$2" -f query='
      query($first: Int, $endCursor: String!){
        viewer {
          starredRepositories(first: $first, after: $endCursor, orderBy: {field: STARRED_AT, direction: DESC}) {
            edges {
              node {
                nameWithOwner
                url
              }
              starredAt
            }
            pageInfo {
              hasNextPage
              endCursor
            }
          }
        }
      }
      '
}

list_stars() {
  result=$(call_star_api "$1" "${endCursor}")
  list="$(echo $result | jq -r '.data.viewer.starredRepositories.edges[] | [.node.nameWithOwner, (.starredAt|fromdateiso8601|gmtime|strflocaltime("%Y-%m-%dT%H:%M:%S%Z"))] | @tsv')"
  echo "${list}" | column -t -s$'\t'
  endCursor=$(echo $result | jq -r '.data.viewer.starredRepositories.pageInfo.endCursor')
  is_end=$(echo $result | jq -r '.data.viewer.starredRepositories.pageInfo.hasNextPage')
}

loop_list_stars(){
  number=$1
  while [ "${is_end}" = "true" ]
  do
    list_stars $number
  done
}
