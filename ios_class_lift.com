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
[ios开发-类的生命周期](http://caiwb1990.iteye.com/blog/1882378)

光有新学IOS的朋友问我为什么要 [[*** alloc]init],今天就专门来说一下一个类的“生命周期”~~~. 

要使用某个类的对象呢，当然首先必须先得到一个指向该对象的变量。 
例如： 
~~~~{objective-c}
Class *classInstance;   
~~~~

在oc中，这个变量的变量名就是classInstance了，类型就是指针，指向某个Class类的实例。 
但是，这只是声明的代码，而不是创建了Class实例。 

一个对象的生命周期是从创建开始，然后接受消息，最后在不需要的时候呗释放掉。 
而怎么创建对象呢？  我们通过向类发送alloc消息，就可以创建对象了。一个类收到了alloc消息后，就会在内存中创建对象，并且返回一个指向新对象的指针，我们可以把指针保存在某个变量里。 
例如： 
~~~~{objective-c}
Class *classInstance = [Class alloc];   
~~~~
这样就创建了一个Class类的实例，并且将返回的对象指针赋给了classInstance变量。这样我们就得到一个指向某个实例的指针，就能向它发送消息了。 

但是，这样我们就能使用了吗？当然不是了。虽然向类发送alloc消息能够创建实例，但是在没有完成初始化之前，新创建的实例是无效的。所以对新创建的实例，必须先向它发送一个初始化消息。 
即： 
~~~~{objective-c}
[classInstance init];   
~~~~

而init返回的也是指针，和alloc消息一样，都指向新创建的对象，所以我们可以嵌套消息发送，先让其收到alloc消息创建对象，然后再收到init消息完成初始化。 
即： 
~~~~{objective-c}
Class *classInstance [[Class alloc] init];   
~~~~

正如开头所说的，完成了一个类的创建。 


而释放对象代码就比较简单了，（实际很复杂，着就不多说了 - -） 
~~~~{objective-c}
classInstance = nil ;    
~~~~
nil是值为0的指针，即java中的null,C里的NULL。一般表示不指向任何对象。 

好吧，今天简单的稍微说到这里。 


最近真忙，忙着减肥。。。唉。
<!-- markdown end -->
</div>
<div class="entry" id="main">
<!-- content -->
<p><a href="http://caiwb1990.iteye.com/blog/1882378">ios开发-类的生命周期</a></p>

<p>光有新学IOS的朋友问我为什么要 [[<em>*</em> alloc]init],今天就专门来说一下一个类的“生命周期”~~~. </p>

<p>要使用某个类的对象呢，当然首先必须先得到一个指向该对象的变量。 
例如： </p>

<pre><code class="language-objective-c">Class *classInstance;   
</code></pre>

<p>在oc中，这个变量的变量名就是classInstance了，类型就是指针，指向某个Class类的实例。 
但是，这只是声明的代码，而不是创建了Class实例。 </p>

<p>一个对象的生命周期是从创建开始，然后接受消息，最后在不需要的时候呗释放掉。 
而怎么创建对象呢？  我们通过向类发送alloc消息，就可以创建对象了。一个类收到了alloc消息后，就会在内存中创建对象，并且返回一个指向新对象的指针，我们可以把指针保存在某个变量里。 
例如： </p>

<pre><code class="language-objective-c">Class *classInstance = [Class alloc];   
</code></pre>这样就创建了一个Class类的实例，并且将返回的对象指针赋给了classInstance变量。这样我们就得到一个指向某个实例的指针，就能向它发送消息了。 

但是，这样我们就能使用了吗？当然不是了。虽然向类发送alloc消息能够创建实例，但是在没有完成初始化之前，新创建的实例是无效的。所以对新创建的实例，必须先向它发送一个初始化消息。 
即： 
<pre><code class="language-objective-c">[classInstance init];   
</code></pre>

<p>而init返回的也是指针，和alloc消息一样，都指向新创建的对象，所以我们可以嵌套消息发送，先让其收到alloc消息创建对象，然后再收到init消息完成初始化。 
即： </p>

<pre><code class="language-objective-c">Class *classInstance [[Class alloc] init];   
</code></pre>

<p>正如开头所说的，完成了一个类的创建。 </p>

<p>而释放对象代码就比较简单了，（实际很复杂，着就不多说了 - -） 
</p><pre><code class="language-objective-c">classInstance = nil ; <br>
</code></pre>nil是值为0的指针，即java中的null,C里的NULL。一般表示不指向任何对象。 <p></p>

<p>好吧，今天简单的稍微说到这里。 </p>

<p>最近真忙，忙着减肥。。。唉。</p>
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
            var path = "ios_class_lift.com";
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
