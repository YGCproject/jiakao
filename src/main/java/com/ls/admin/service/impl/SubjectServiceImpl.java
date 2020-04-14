package com.ls.admin.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import  com.ls.admin.service.SubjectService;
import  com.ls.admin.dao.SubjectMapper;

import java.util.HashMap;
import java.util.List;

/**
 * @author langxiaohua
 * date 2020-04-14
 */
@Service
public class SubjectServiceImpl  implements SubjectService {
    @Autowired
    private SubjectMapper subjectMapper;


    @Override
    public List<HashMap> selectSubject(int pages, int limit) {
        return subjectMapper.selectSubject(pages,limit);
    }

    @Override
    public int selectSubjectCount() {
        return subjectMapper.selectSubjectCount();
    }

    @Override
    public List<HashMap> selectSubjectByName(HashMap parme) {
        return subjectMapper.selectSubjectByName(parme);
    }

    @Override
    public int selectSubjectByNameCount(String subjectName) {
        return subjectMapper.selectSubjectByNameCount(subjectName);
    }

    @Override
    public String selectInsertId() {
        return subjectMapper.selectInsertId();
    }

    @Override
    public int insertAnswer(String optionOne, String content) {
        return subjectMapper.insertAnswer(optionOne,content);
    }

    @Override
    public int insertSubject(String aId, String bId, String cId, String dId, String trueOption, String subjectName) {
        return subjectMapper.insertSubject(aId,bId,cId,dId,trueOption,subjectName);
    }

    @Override
    public int updateAnswer(HashMap parme) {
        return subjectMapper.updateAnswer(parme);
    }

    @Override
    public int updateSubject(HashMap parme) {
        return subjectMapper.updateSubject(parme);
    }
}
