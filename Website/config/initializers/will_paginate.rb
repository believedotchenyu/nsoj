WillPaginate::ViewHelpers.pagination_options[:previous_label ] =  "上一页"
WillPaginate::ViewHelpers.pagination_options[:next_label ] =  "下一页"

=begin
@@pagination_options  =  { 
         : prev_label    =>   ' 上一页 ' ,   #这个一般是用在我们中文网站上的时候需要进行改动，默认是 << Previous
         : next_label    =>   ' 下一页 ' ,   #这个一般是用在我们中文网站上的时候需要进行改动，默认是 Next >>
         : inner_window  =>   4 ,   # inner_window  控制显示当前页临近的多少个链接 ，默认是4
         : outer_window  =>   1 , # outer_window 控制显示首/末页临近的多少个链接，默认是1
        :page_links => false, # 如果是false的时候，只显示上一页和下一页 (默认是 true)
         : separator     =>   '   ' ,   # 这个参数是用来设置页码之间 的分隔符的，用空格或者（|）或者其他的都可以 
         : param_name    =>   : page ,   #这个参数是用来我们点击页码连接的时候传递的参数的名称，一般不用改动
        :class           =>  'pagination' ,  #这个是用来给分页的元素家heml的类名的，可以通过这个类名进行样式布局。 
        }
=end
