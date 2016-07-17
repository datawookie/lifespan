#!/bin/bash

# Field order: year, month, dow, age, sex

for year in 2014 2013 2012 2011 2010 2009 2008 2007 2006 2005 2004 2003
do
  unzip -qq -c mort${year}us.zip | cut --output-delimiter=" " -c 102-105,65-66,85,71-73,69 | awk '{print $5, $1, $4, $3, $2}' | bzip2 >mort-${year}.txt.bz2
done

for year in 2002 2001 2000 1999 1998 1997 1996
do
  unzip -qq -c mort${year}us.zip | cut --output-delimiter=" " -c 115-118,55-56,83,64-66,59 | awk '{print $5, $1, $4, $3, $2}' | bzip2 >mort-${year}.txt.bz2
done

for year in 1995 1994
do
  unzip -qq -c mort${year}us.zip | cut --output-delimiter=" " -c 1-2,55-56,83,64-66,59 | awk '{print 1900+$1, $2, $5, $4, $3}' | bzip2 >mort-${year}.txt.bz2
done