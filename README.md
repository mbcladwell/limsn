# limsn
Main LIMS*Nucleus Guile/Guix 

incorporate make
make guix package
import layouts to admin page
show ip in sessions
Show proper page image for registering a licence in help /software/lickey
How are registered users handled in software?
plate/getpltforps?id=1 2nd 3rd table missing indentation

Based on ln7 which run guile3.0.5/Datatables/bootstrap/postgres


for make to work must modify load path
export GUILE_LOAD_PATH="/home/mbc/projects/limsn/limsn/lib${GUILE_LOAD_PATH:+:}$GUILE_LOAD_PATH"


# Bugs

Click on layout 41 fails.  
41 is used as destination for all 1536 layouts, however only 1 src should be returned in postgres query
select src from layout_source_dest where dest = 41
so query fails.  Either provide each 1536 layout with a unique dest (all blanks) or inactivate the hyperlink for 41
