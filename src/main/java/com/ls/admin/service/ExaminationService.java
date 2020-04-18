package com.ls.admin.service;

import java.util.HashMap;
import java.util.List;

/**
 * @Author: luquanlin
 * @Date: 2020/3/29 22:25
 * @VERSION: 1.0
 **/
public interface ExaminationService {
    boolean insertLoad(String name, String url);
    List<HashMap> selectExamAll();
}
