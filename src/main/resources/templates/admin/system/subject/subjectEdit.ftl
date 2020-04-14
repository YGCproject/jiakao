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
    <script type="text/javascript" src="${base}/static/layui/layui.js"></script>
    <script type="text/javascript" src="${base}/static/js/jquery.min.js"></script>
</head>


<body>
<style>
    body {
        overflow-y: scroll;
    }

    /* 禁止刷新后出现横向滚动条 */
</style>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
    <legend>题库修改</legend>
</fieldset>
<form class="layui-form layui-form-pane" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">题目</label>
        <div class="layui-input-block">
            <input type="text" name="subjectName" id="subjectName" autocomplete="off" placeholder="请输入题目" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">正确选项</label>
        <div class="layui-input-inline">
            <select name="interest" id="true" lay-filter="aihao">
                <option value="请选择"></option>
                <option value="A">选项A</option>
                <option value="B">选项B</option>
                <option value="C">选项C</option>
                <option value="D">选项D</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">选项A</label>
            <div class="layui-input-inline">
                <input type="text" name="number" ID="A" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">选项B</label>
            <div class="layui-input-inline">
                <input type="text" name="number" ID="B" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">选项C</label>
            <div class="layui-input-inline">
                <input type="text" name="number" ID="C" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">选项D</label>
            <div class="layui-input-inline">
                <input type="text" name="number" ID="D" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="position:absolute;bottom: 40px">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" id="Submission">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </div>
</form>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/javascript">
    var form = layui.form;
    var parentData = parent.objData;
    console.log(parentData)
    layui.use(['form', 'layedit', 'laydate', 'table', 'jquery'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate
            , $ = layui.jquery
            , table = layui.table;

        //判断是否修改并初始化表单
        if (parentData != null)
        {
            $('#subjectName').val(parentData.subject_name)
            let trueoption = parentData.true_option
            console.log(trueoption)
            $("#true").val(trueoption);
            console.log( $("#true").val())
            layui.form.render("select");
            $('#A').val(parentData.a_content)
            $('#B').val(parentData.b_content)
            $('#C').val(parentData.c_content)
            $('#D').val(parentData.d_content)
        }

        //重构函数
        function houseRelode() {
            table.reload("demo", {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , url: "/subject/selectSubject"
            });
        }

        // 房屋提交事件
        $("#Submission").click(function (ev) {
            ev.preventDefault()

            let subjectName = $("#subjectName").val()
            let trueOption = $("#true").val()
            let A = $("#A").val()
            let B = $("#B").val()
            let C = $("#C").val()
            let D = $("#D").val()
            if(subjectName==""||trueOption==""||A==""||B==""||C==""||D==""){
                layer.msg("请填写完整信息",{icon:2})

            }else{
                if (parentData == null){
                    $.ajax({
                        url:"/subject/insertSubject",
                        type:"get",
                        data:{
                            subjectName:subjectName,
                            trueOption:trueOption,
                            A:A,
                            B:B,
                            C:C,
                            D:D
                        },
                        success:function (res) {
                            alert("insert")
                            console.log(res);
                            if (res == 1){
                                layer.msg("插入成功！")
                                var index = parent.layer.getFrameIndex(window.name)
                                parent.layer.close(index)
                            }
                        }
                    })
                }else {
                    $.ajax({
                        url:"/subject/updateSubject",
                        type:"get",
                        data:{
                            subjectId:parentData.subject_id,
                            subjectName:subjectName,
                            trueOption:trueOption,
                            A:A,
                            B:B,
                            C:C,
                            D:D,
                            aId:parentData.a_id,
                            bId:parentData.b_id,
                            cId:parentData.c_id,
                            dId:parentData.d_id
                        },
                        success:function (res) {
                           layer.msg("修改成功")
                            if (res == 1){
                                var index = parent.layer.getFrameIndex(window.name)
                                parent.layer.close(index)
                            }
                        }
                    })
                }

                }



        })
    });

</script>
</body>
</html>