<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${base}/static/css/examination.css" media="all"/>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
<div class="carOneTest">科目一考试</div>

<form class="layui-form" action="">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card" id="targetOptions">
            </div>
        </div>

        <div>
            <h1 style="float: right;padding-right: 200px;padding-top: 4px" id="fractions"></h1>

        </div>
    </div>
</form>


<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form', 'upload', 'layer', 'flow'], function () {
        var flow = layui.flow;
        var $ = layui.jquery


        //模拟数据插入

        var a = [
            {
                target_id: 1,
                target_name: '题目A',
                options: [
                    {
                        options_id: 1,
                        options_content: '我是选线A'
                    },
                    {
                        options_id: 2,
                        options_content: '我是选线B'
                    },
                    {
                        options_id: 3,
                        options_content: '我是选线C'
                    },
                    {
                        options_id: 4,
                        options_content: '我是选线D'
                    },]
            },
            {
                target_id: 2,
                target_name: '题目B',
                options: [
                    {
                        options_id: 1,
                        options_content: '我是选线A'
                    },
                    {
                        options_id: 2,
                        options_content: '我是选线B'
                    },
                    {
                        options_id: 3,
                        options_content: '我是选线C'
                    },
                    {
                        options_id: 4,
                        options_content: '我是选线D'
                    },]
            },
            {
                target_id: 3,
                target_name: '题目C',
                options: [
                    {
                        options_id: 1,
                        options_content: '我是选线A'
                    },
                    {
                        options_id: 2,
                        options_content: '我是选线B'
                    },
                    {
                        options_id: 3,
                        options_content: '我是选线C'
                    },
                    {
                        options_id: 4,
                        options_content: '我是选线D'
                    },]
            },
        ];
        var b
        var i = 1
        $.ajax({
            url: '/examination/selectExamAll',
            type: 'post',
            success: function (res) {
                var result = res.data
                console.log("re", result)
                result.forEach((item, index) => {
                    $('#targetOptions').append('<div class="layui-card-header" style="background-color: #F2F2F2;margin-top:20px " >\n' +
                        '            <label class="layui-form-label" style="font-size: 16px;width: 30%;text-align: left;margin-top: 3px ">' + i + '.' + item.subject_name + ' </label>\n' +
                        '        </div>' +
                        '<div class="layui-card-body" style="margin: 0;padding: 0 0 2px 20px">\n' +
                        '            <span>\n' +
                        '                <input class="radio" lay-filter="options" type="radio"\n' +
                        '                       name="' + item.id + '" value="' + item.a_id + '" title="' + item.a_content + '" lay-skin="primary"> '+item.a_content+' \n' +
                        '            </span>\n' +
                        '        </div>' +
                        '<div class="layui-card-body" style="margin: 0;padding: 0 0 2px 20px">\n' +
                        '            <span>\n' +
                        '                <input class="radio" lay-filter="options" type="radio"\n' +
                        '                       name="' + item.id + '" value="' + item.b_id + '" title="' + item.b_content + '" lay-skin="primary">'+item.b_content+' \n' +
                        '            </span>\n' +
                        '        </div>' +
                        '<div  class="layui-card-body" style="margin: 0;padding: 0 0 2px 20px">\n' +
                        '            <span>\n' +
                        '                <input class="radio" lay-filter="options" type="radio"\n' +
                        '                       name="' + item.id + '" value="' + item.c_id + '" title="' + item.c_content + '" lay-skin="primary">'+item.c_content+'\n' +
                        '            </span>\n' +
                        '        </div>' +
                        '<div class="layui-card-body" style="margin: 0;padding: 0 0 2px 20px">\n' +
                        '            <span>\n' +
                        '                <input class="radio" lay-filter="options" type="radio"\n' +
                        '                       name="' + item.id + '" value="' + item.d_id + '" title="' + item.d_content + '" lay-skin="primary">'+item.d_content+'\n' +
                        '            </span>\n' +
                        '        </div>');
                i++
                // $('#targetOptions').append()
            })
            }
        })
        // for (var index in a) {
        //     b = a[index].options
        //     $('#targetOptions').append('<div class="layui-card-header" style="background-color: #F2F2F2;margin-top:20px " >\n' +
        //         '            <label class="layui-form-label" style="font-size: 16px;width: 30%;text-align: left;margin-top: 3px ">' + i + '.' + a[index].target_name + ' </label>\n' +
        //         '        </div>');
        //     i++
        //     for (var index1 in b) {
        //         $('#targetOptions').append('<div class="layui-card-body" style="margin: 0;padding: 0 0 2px 20px">\n' +
        //             '            <span>\n' +
        //             '                <input lay-filter="options" type="radio"\n' +
        //             '                       name="' + a[index].target_id + '" value="' + b[index1].options_id + '" title="' + b[index1].options_content + '" lay-skin="primary">\n' +
        //             '            </span>\n' +
        //             '        </div>')
        //     }
        // }
        layui.form.render();

    });
</script>

</body>
</html>