package com.ls.admin.controller.examination;

import com.ls.admin.service.ExaminationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author: luquanlin
 * @Date: 2020/3/29 22:10
 * @VERSION: 1.0
 **/

@Controller
@RequestMapping("examination")
public class examination {
    @Autowired
    private ExaminationService examinationService;

    @GetMapping("examination")
    public String list() {
        return "examination/examination";
    }
}
