#!/bin/awk -f

{print "BookmarkBegin"}
{print "BookmarkTitle:", $2}
{print "BookmarkLevel:", $1}
{print "BookmarkPageNumber:", $3}
