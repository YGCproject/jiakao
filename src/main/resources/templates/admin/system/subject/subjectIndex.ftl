
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
    body{overflow-y: scroll;} /* 禁止刷新后出现横向滚动条 */
</style>

<!--搜索框-->
<div class="demoTable">
    题目名称：
    <div class="layui-inline">
        <input class="layui-input" name="subject_name" id="subject_name" placeholder="搜索房屋" autocomplete="off">
    </div>
    <button type="button" class="layui-btn"  id="addSubject">
        <i class="layui-icon">&#xe608;</i> 添加
    </button>
</div>
<table id="demo" lay-filter="test"></table>

<!--生成序号-->
<script  type="text/html" id="xuhao">
    {{d.LAY_TABLE_INDEX+1}}
</script>


<!--自定义模板状态量-->
<!--<script type="text/html" id="titleTpl">-->
<!--    {{#  if(d.batch_Hide == 1){ }}-->
<!--    <button type="button" class="layui-btn layui-btn-sm" disabled="disabled">开启中</button>-->
<!--    {{#  } else if(d.batch_Hide == 0){ }}-->
<!--    <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" disabled="disabled">未开启</button>-->
<!--    {{#  }else if(d.batch_Hide == 2){ }}-->
<!--    <button type="button" class="layui-btn layui-btn-sm layui-btn-warm" disabled="disabled">暂停中</button>-->
<!--    {{#  }else if(d.batch_Hide == 3){ }}-->
<!--    <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" disabled="disabled">已结束</button>-->
<!--    {{#  } }}-->
<!--</script>-->

<!--表格的操作-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/javascript">

    layui.use(['form', 'layedit', 'laydate','table','jquery'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate
            ,$=layui.jquery
            , table = layui.table;

        //重构函数
        function houseRelode(){
            table.reload("demo",{
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,url:"/subject/selectSubject"
            });
        }


        //数据表表头
        table.render({
            elem: '#demo'
            ,url: '/subject/selectSubject' //数据接口
            ,page: true //开启分页
            ,cols: [
                [ //表头
                    {field: '序号', templet: '#xuhao',title: '序号', width:'10%', sort: true, fixed: 'left', align: 'center'},
                    {field: 'subject_name', title: '题目名称', width: '20%',align: 'center'},
                    {field: 'a_content', title: '选项A', width: '15%',align: 'center'},
                    {field: 'b_content', title: '选项B', width: '15%',align: 'center'},
                    {field: 'c_content', title: '选项C', width: '15%',align: 'center'},
                    {field: 'd_content', title: '选项D', width: '15%',align: 'center'},
                    {title: '操作', width: '9%', toolbar: '#barDemo'}
                ]
            ]
        });
        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            console.log(data)
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            $("#id").html("填充代码");
            // console.log(tr[0].innerHTML)  获取DOM结构

            if(layEvent === 'del'){ //删除
                $.ajax({
                    url:'/house/deleteOneHouse',
                    type:'post',
                    data:{
                        houseId: data.house_id
                    },
                    success:function (res) {
                        layer.msg(res.result);
                        houseRelode();
                    }
                })
            }else if(obj.event === 'edit'){

                var subjectName = $('#subject_name');
                objData = obj.data;
                layer.open({
                    type:2
                    ,skin:'layui-layer-rim'//加上边框
                    ,maxmin: true //开启最大化最小化按钮
                    ,area: ["700px","470px"]
                    ,title: "题库修改"
                    ,content:"/subject/goSubjectEdit"
                    ,success: function (layero,index) {
                        var body = layer.getChildFrame('body', index);
                        var iframe = window['layui-layer-iframe' + index];
                    },
                    end:function () {
                        objData = null;
                        if(subjectName.val()==""){
                            table.reload("demo",{
                                page: {
                                    curr: 1 //重新从第 1 页开始
                                }
                                ,url:"/subject/selectSubject"

                            });
                        }else{
                            table.reload("demo",{
                                page: {
                                    curr: 1 //重新从第 1 页开始
                                }
                                ,url:"/subject/selectSubjectByName"
                                ,where: {
                                    houseName: house_name.val()
                                }
                            });
                        }

                    }
                })
            }
        });

        //查询框重载
        $("#subject_name").bind("input propertychange",function () {
            var subjectName = $('#subject_name');
            //执行重载
            if(subjectName.val()==""){
                table.reload("demo",{
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,url:"/subject/selectSubject"

                });
            }else{
                table.reload("demo",{
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,url:"/subject/selectSubjectByName"
                    ,where: {
                        subjectName: subjectName.val()
                    }
                });
            }

        })
        //添加用户
        $("#addSubject").click(function () {

            var subjectName = $('#subject_name');
            layer.open({
                type:2
                ,skin:'layui-layer-rim'//加上边框
                ,maxmin: true //开启最大化最小化按钮
                ,area: ["700px","470px"]
                ,title: "新增房屋信息"
                ,content:"/subject/goSubjectEdit"
                ,success: function (layero,index) {
                    var body = layer.getChildFrame('body', index);
                    var iframe = window['layui-layer-iframe' + index];
                },
                end:function () {
                    if(subjectName.val()==""){
                        table.reload("demo",{
                            page: {
                                curr: 1 //重新从第 1 页开始
                            }
                            ,url:"/subject/selectSubject"

                        });
                    }else{
                        table.reload("demo",{
                            page: {
                                curr: 1 //重新从第 1 页开始
                            }
                            ,url:"/subject/selectSubjectByName"
                            ,where: {
                                subjectName: subjectName.val()
                            }
                        });
                    }

                }
            })
        })
    });

</script>
</body>
</html>