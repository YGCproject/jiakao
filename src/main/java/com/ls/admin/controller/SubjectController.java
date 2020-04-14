package com.ls.admin.controller;

import com.ls.admin.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author langxiaohua
 * 题库管理控制器
 * date 2020-04-14
 */
@RequestMapping("subject")
@Controller
public class SubjectController {

    @Autowired
    private SubjectService subjectService;

    //跳转到list页面
    @GetMapping("goSubject")
    public String goSubject()
    {
        return "admin/system/subject/subjectIndex";
    }
    //跳转到题库修改页面
    @GetMapping("goSubjectEdit")
    public String goSubjectEdit()
    {
        return "admin/system/subject/subjectEdit";
    }
    //查询所有题库
    @ResponseBody
    @RequestMapping("selectSubject")
    public Map selectSubject(int page, int limit)
    {
        int pages=(page-1)*limit;
        Map result=new HashMap();
        List<HashMap> subjectList = subjectService.selectSubject(pages,limit);
        int subjectCount = subjectService.selectSubjectCount();
        result.put("code",0);
        result.put("msg","");
        result.put("count",subjectCount);
        result.put("data",subjectList);
        return result;
    }

    //题库条件模糊查询
    @ResponseBody
    @RequestMapping("selectSubjectByName")
    public Map selectAccountUsers(String subjectName,int page,int limit){
            int pages=(page-1)*limit;
        Map result=new HashMap();
        HashMap parme = new HashMap();
        parme.put("subjectName",subjectName);
        parme.put("pages",pages);
        parme.put("limit",limit);
        List<HashMap> houseList = new ArrayList<HashMap>();
        try {
            houseList = subjectService.selectSubjectByName(parme);
        }catch (Exception e)
        {
            System.err.println( e.getMessage());
        }

        int houseCount = subjectService.selectSubjectByNameCount(subjectName);
        result.put("code",0);
        result.put("msg","");
        result.put("count",houseCount);
        result.put("data",houseList);
        return result;
    }

    //插入房屋
    @ResponseBody
    @RequestMapping("insertSubject")
    public int insertSubject(
            @RequestParam("subjectName") String subjectName,
            @RequestParam("trueOption") String trueOption,
            @RequestParam("A") String A,
            @RequestParam("B") String B,
            @RequestParam("C") String C,
            @RequestParam("D") String D
    ){

        String aId;
        String bId;
        String cId;
        String dId;
        String  optionOne;
        String  content;
        optionOne = "A";
        content = A;
        int  a = subjectService.insertAnswer(optionOne,content);
        optionOne = "B";
        content = B;
        aId = subjectService.selectInsertId();
        subjectService.insertAnswer(optionOne,content);
        bId = subjectService.selectInsertId();
        optionOne = "C";
        content = C;
        subjectService.insertAnswer(optionOne,content);
        cId = subjectService.selectInsertId();
        optionOne = "D";
        content = D;
        subjectService.insertAnswer(optionOne,content);
        dId = subjectService.selectInsertId();
        int ifInsert = subjectService.insertSubject(aId,bId,cId,dId,trueOption,subjectName);
        return ifInsert;
    }


    //修改房屋
    @ResponseBody
    @RequestMapping("updateSubject")
    public int updateSubject(
            @RequestParam("subjectId") String subjectId,
            @RequestParam("subjectName") String subjectName,
            @RequestParam("trueOption") String trueOption,
            @RequestParam("A") String A,
            @RequestParam("B") String B,
            @RequestParam("C") String C,
            @RequestParam("D") String D,
            @RequestParam("aId") String aId,
            @RequestParam("bId") String bId,
            @RequestParam("cId") String cId,
            @RequestParam("dId") String dId
    ){

        HashMap parme = new HashMap();
        parme.put("id",aId);
        parme.put("content",A);
        subjectService.updateAnswer(parme);
        parme.put("id",bId);
        parme.put("content",B);
        subjectService.updateAnswer(parme);
        parme.put("id",cId);
        parme.put("content",C);
        subjectService.updateAnswer(parme);
        parme.put("id",dId);
        parme.put("content",D);
        subjectService.updateAnswer(parme);
        HashMap subjectParme = new HashMap();
        subjectParme.put("subjectName",subjectName);
        subjectParme.put("trueOption",trueOption);
        subjectParme.put("subjectId",subjectId);
        int ifUpdate = subjectService.updateSubject(subjectParme);
        return ifUpdate;
    }

}
