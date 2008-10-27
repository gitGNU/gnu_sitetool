(p (@ class "terminal")
"
Start symbol syntax

syntax: header body ;
header: AUTOGEN DEFINITIONS SYMBOL ';' ;
body: | main_groups ;
main_groups: main_group | main_group main_groups ;
main_group: SYMBOL '=' '{' main_group_items '}' ';' ;
main_group_items: main_group_item | main_group_item main_group_items ;
main_group_item: sub_variable | sub_group | sub_indexed ;
sub_variable: SYMBOL '=' QUOTEDSTRING ';' ;
sub_group: SYMBOL '=' '{' sub_group_id sub_group_items '}' ';' ;
sub_group_id: 'id' '=' QUOTEDSTRING ';' ;
sub_group_items: sub_group_item | sub_group_item sub_group_items ;
sub_group_item: sub_variable | sub_container ;
sub_container: SYMBOL '=' '{' sub_container_items '}' ';' ;
sub_container_items: sub_indexed_items | sub_group_items ;
sub_indexed_items: sub_indexed_item | sub_indexed_item sub_indexed_items ;
sub_indexed_item: SYMBOL '[' DECIMAL ']' '=' '{' sub_group_items '}' ';' ;

"
)
