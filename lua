<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="Keywords" content="blog"/>
    <meta name="Description" content="blog"/>
    <title>Hellc</title>
    <link rel="shortcut icon" href="/static/favicon.png"/>
    <link rel="stylesheet" type="text/css" href="/main.css" />
</head>
<body>
<div class="main">
    <div class="header">
    	<ul id="pages">
            <li><a href="/">home</a></li>
            <li><a href="/#/tags">tags</a></li>
            <li><a href="/#/archive">archive</a></li>
    	</ul>
    </div>
	<div class="wrap-header">
	<h1>
    <a href="/" id="title"></a>
	</h1>
	</div>
<div id="md" style="display: none;">
<!-- markdown -->
[lua自定义log ]( http://caiwb1990.iteye.com/blog/2220408)

分享个log,可以打印各种类型，包括嵌套table 


    cc.exports.cwblog = function(...)
    if config.debug==1 then
		local text = ""
		local xn = 0
		local function textLineT(xn)
			-- body
			for i=1,xn do
				text = text.."\t"
			end
		end

		local function printTable(i,v)
			-- body
			if type(v) == "table" then
				textLineT(xn)
				xn = xn + 1
				text = text..""..i..":Table{\n"
				table.foreach(v,printTable)
				textLineT(xn)
				text = text.."}\n"
				xn = xn - 1
			elseif type(v) == nil then
				textLineT(xn)
				text = text..i..":nil\n"
			else
				textLineT(xn)
				text = text..i..":"..tostring(v).."\n" 
			end
		end
		local function dumpParam(tab)
			for i=1, #tab do  
				if tab[i] == nil then 
					text = text.."nil\t"
				elseif type(tab[i]) == "table" then 
					xn = xn + 1
					text = text.."\ntable{\n"
					table.foreach(tab[i],printTable)
					text = text.."\t}\n"
				else
					text = text..tostring(tab[i]).."\t"
				end
			end
		end
		local x = ...
		if type(x) == "table" then
			table.foreach(x,printTable)
		else
			dumpParam({...})
		end
		print(text)
		end
end


<!-- markdown end -->
</div>
<div class="entry" id="main">
<!-- content -->
<p><a href="http://caiwb1990.iteye.com/blog/2220408">lua自定义log </a></p>

<p>分享个log,可以打印各种类型，包括嵌套table </p>

<pre><code>cc.exports.cwblog = function(...)
if config.debug==1 then
    local text = ""
    local xn = 0
    local function textLineT(xn)
        -- body
        for i=1,xn do
            text = text.."\t"
        end
    end

    local function printTable(i,v)
        -- body
        if type(v) == "table" then
            textLineT(xn)
            xn = xn + 1
            text = text..""..i..":Table{\n"
            table.foreach(v,printTable)
            textLineT(xn)
            text = text.."}\n"
            xn = xn - 1
        elseif type(v) == nil then
            textLineT(xn)
            text = text..i..":nil\n"
        else
            textLineT(xn)
            text = text..i..":"..tostring(v).."\n" 
        end
    end
    local function dumpParam(tab)
        for i=1, #tab do  
            if tab[i] == nil then 
                text = text.."nil\t"
            elseif type(tab[i]) == "table" then 
                xn = xn + 1
                text = text.."\ntable{\n"
                table.foreach(tab[i],printTable)
                text = text.."\t}\n"
            else
                text = text..tostring(tab[i]).."\t"
            end
        end
    end
    local x = ...
    if type(x) == "table" then
        table.foreach(x,printTable)
    else
        dumpParam({...})
    end
    print(text)
    end
</code></pre>

<p>end</p>
<!-- content end -->
</div>
<br>
<br>
    <div id="disqus_thread"></div>
	<div class="footer">
		<p>© Copyright 2014 by Hellc, Designed by Hellc</p>
	</div>
</div>
<script src="main.js"></script>
<script src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ["\\(", "\\)"]], processEscapes: true}});
</script>
<script id="content" type="text/mustache">
    <h1>{{title}}</h1>
    <div class="tag">
    {{date}}
    {{#tags}}
    <a href="/#/tag/{{name}}">#{{name}}</a>
    {{/tags}}
    </div>
</script>
<script id="pagesTemplate" type="text/mustache">
    {{#pages}}
    <li>
        <a href="{{path}}">{{title}}</a>
    </li>
    {{/pages}}
</script>
<script>
$(document).ready(function() {
    $.ajax({
        url: "main.json",
        type: "GET",
        dataType: "json",
        success: function(data) {
            $("#title").html(data.name);
            var pagesTemplate = Hogan.compile($("#pagesTemplate").html());
            var pagesHtml = pagesTemplate.render({"pages": data.pages});
            $("#pages").append(pagesHtml);
            //path
            var path = "lua";
            //path end
            var now = 0;
            for (var i = 0; i < data.posts.length; ++i)
                if (path == data.posts[i].path)
                    now = i;
            var post = data.posts[now];
            var tmp = post.tags.split(" ");
            var tags = [];
            for (var i = 0; i < tmp.length; ++i)
                if (tmp[i].length > 0)
                    tags.push({"name": tmp[i]});
            var contentTemplate = Hogan.compile($("#content").html());
            var contentHtml = contentTemplate.render({"title": post.title, "tags": tags, "date": post.date});
            $("#main").prepend(contentHtml);
            if (data.disqus_shortname.length > 0) {
                var disqus_shortname = data.disqus_shortname;
                (function() {
                    var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                    dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
                    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                })();
            }
        }
    });
});
</script>
</body>
</html>
