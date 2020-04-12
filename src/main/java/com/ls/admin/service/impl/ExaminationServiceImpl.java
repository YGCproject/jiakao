package com.ls.admin.service.impl;

import com.ls.admin.dao.ExaminationDao;
import com.ls.admin.service.ExaminationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author: luquanlin
 * @Date: 2020/3/29 22:27
 * @VERSION: 1.0
 **/
@Service
public class ExaminationServiceImpl implements ExaminationService {
    @Autowired
    private ExaminationDao examinationDao;

    @Override
    public boolean insertLoad(String name, String url) {
        int result = examinationDao.insertLoad(name,url);
        if (result>0){
            return  true;
        }
        return false;
    }
}
