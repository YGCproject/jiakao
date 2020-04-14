package com.ls.admin.service;

import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

/**
 * @author langxiaohua
 * date 2020-04-14
 */

public interface SubjectService {

    //查找所有题目
    List<HashMap> selectSubject(int pages, int limit);
    //查找所有题目数量
    int selectSubjectCount();

    //查找所有题目模糊查找
    List<HashMap> selectSubjectByName(HashMap parme);
      //查找所有题目模糊查找数量
    int selectSubjectByNameCount(@Param("subjectName") String subjectName);


    String selectInsertId();
    //插入选项
    int insertAnswer(@Param("optionOne") String optionOne,@Param("content") String content);
    //插入题目
    int insertSubject(@Param("aId") String aId,@Param("bId") String bId,@Param("cId") String cId,
                      @Param("dId") String dId,@Param("trueOption") String trueOption,@Param("subjectName") String subjectName);

    //修改选项
    int updateAnswer(HashMap parme);
    //修改题目
    int updateSubject(HashMap parme);
}
