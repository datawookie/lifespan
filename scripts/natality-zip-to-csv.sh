#!/bin/bash

# Data downloaded from http://www.cdc.gov/nchs/data_access/vitalstatsonline.htm.

unzip -qq -c Nat2014US.zip | cut --output-delimiter=" " -c 9-12,13-14,23,475   | bzip2 >nat-2014.csv.bz2
funzip Nat2013US.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29  | bzip2 >nat-2013.csv.bz2
funzip Nat2012us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29  | bzip2 >nat-2012.csv.bz2
funzip Nat2011us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29  | bzip2 >nat-2011.csv.bz2
funzip Nat2010us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29  | bzip2 >nat-2010.csv.bz2
funzip Nat2009us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29  | bzip2 >nat-2009.csv.bz2
funzip Nat2008us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29  | bzip2 >nat-2008.csv.bz2
funzip Nat2007us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29  | bzip2 >nat-2007.csv.bz2
funzip Nat2006us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29  | bzip2 >nat-2006.csv.bz2
unzip -qq -c Nat2005us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29 | bzip2 >nat-2005.csv.bz2
unzip -qq -c Nat2004us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29 | bzip2 >nat-2004.csv.bz2
unzip -qq -c Nat2003us.zip | cut --output-delimiter=" " -c 15-18,19-20,436,29 | bzip2 >nat-2003.csv.bz2
funzip Nat2002us.zip | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-2002.csv.bz2
funzip Nat2001us.zip | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-2001.csv.bz2
funzip Nat2000us.zip | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-2000.csv.bz2
funzip Nat1999us.zip | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1999.csv.bz2
funzip Nat1998us.zip | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1998.csv.bz2
funzip Nat1997us.zip | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1997.csv.bz2
funzip Nat1996us.zip | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1996.csv.bz2
funzip Nat1995us.zip | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1995.csv.bz2
funzip Nat1994us.zip | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1994.csv.bz2

# bzip2 -dc nat-1993.txt.bz2 | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1993.csv.bz2
# bzip2 -dc nat-1992.txt.bz2 | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1992.csv.bz2
# bzip2 -dc nat-1991.txt.bz2 | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1991.csv.bz2
# bzip2 -dc nat-1990.txt.bz2 | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1990.csv.bz2
# bzip2 -dc nat-1989.txt.bz2 | cut --output-delimiter=" " -c 1-4,172-173,189,180 | bzip2 >nat-1989.csv.bz2
# bzip2 -dc nat-1988.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1988.csv.bz2
# bzip2 -dc nat-1987.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1987.csv.bz2
# bzip2 -dc nat-1986.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1986.csv.bz2
# bzip2 -dc nat-1985.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1985.csv.bz2
# bzip2 -dc nat-1984.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1984.csv.bz2
# bzip2 -dc nat-1983.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1983.csv.bz2
# bzip2 -dc nat-1982.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1982.csv.bz2
# bzip2 -dc nat-1981.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1981.csv.bz2
# bzip2 -dc nat-1980.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1980.csv.bz2
# bzip2 -dc nat-1979.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1979.csv.bz2
# bzip2 -dc nat-1978.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1978.csv.bz2
# bzip2 -dc nat-1977.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1977.csv.bz2
# bzip2 -dc nat-1976.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1976.csv.bz2
# bzip2 -dc nat-1975.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1975.csv.bz2
# bzip2 -dc nat-1974.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1974.csv.bz2
# bzip2 -dc nat-1973.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1973.csv.bz2
# bzip2 -dc nat-1972.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1972.csv.bz2
# bzip2 -dc nat-1971.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1971.csv.bz2
# bzip2 -dc nat-1970.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1970.csv.bz2
# bzip2 -dc nat-1969.txt.bz2 | cut --output-delimiter=" " -c 35,84-85 | awk '{print 1988, $2, 0, $1}' | bzip2 >nat-1969.csv.bz2
