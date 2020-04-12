<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all"/>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>


<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>指定允许上传的文件类型</legend>
</fieldset>

<button type="button" class="layui-btn" id="test3"><i class="layui-icon"></i>上传文件</button>
<button type="button" class="layui-btn" id="test5"><i class="layui-icon"></i>上传视频</button>

<div style="margin-top: 10px;">
    <!-- 示例-970 -->
    <ins class="adsbygoogle" style="display:inline-block;width:970px;height:90px"
         data-ad-client="ca-pub-6111334333458862" data-ad-slot="3820120620"></ins>
</div>


<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use('upload', function () {
        var $ = layui.jquery
            , upload = layui.upload;

        //指定允许上传的文件类型
        upload.render({
            elem: '#test3'
            , url: '${base}/examination/insertVideoUrl' //改成您自己的上传接口
            , accept: 'file' //普通文件
            , done: function (res) {
                layer.msg('上传成功');
                console.log(res);
            }
        });

        upload.render({
            elem: '#test5'
            , url: '${base}/examination/insertVideoUrl' //改成您自己的上传接口
            , accept: 'video' //视频
            , done: function (res) {
                layer.msg('上传成功');
                console.log(res)
            }
        });


    });
</script>

</body>
</html>