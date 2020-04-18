package com.ls.admin.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * @Author: luquanlin
 * @Date: 2020/3/29 22:20
 * @VERSION: 1.0
 **/
@Repository
public interface ExaminationDao {
    int insertLoad(@Param("name") String name,@Param("url") String url);

    List<HashMap> selectExamAll();
}
