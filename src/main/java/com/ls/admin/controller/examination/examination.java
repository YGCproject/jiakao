package com.ls.admin.controller.examination;

import com.ls.admin.service.ExaminationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

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
    public String upload() {
        return "examination/examination";
    }

    @GetMapping("upload")
    public String list() {
        return "examination/upload";
    }

    @RequestMapping("insertVideoUrl")
    @ResponseBody
    public Map insertVideoUrl(MultipartFile file, HttpServletRequest request) {
        Map result = new HashMap();
        if (file.isEmpty()) {
            result.put("data", "文件为空");
            return result;
        }

        String realPath = "D:\\jiakao\\learning\\src\\main\\resources\\static\\video";

        File dir = new File(realPath);
        if (!dir.isDirectory()) {//文件目录不存在，就创建一个
            dir.mkdirs();
        }

        try {
            String filename = file.getOriginalFilename();
            //服务端保存的文件对象
            File fileServer = new File(dir, filename);
            System.out.println("file文件真实路径:" + fileServer.getAbsolutePath());
            //2，实现上传
            file.transferTo(fileServer);
            String filePath = request.getScheme() + "://" +
                    request.getServerName() + ":"
                    + request.getServerPort()
                    + "/static/video/" + filename;
            //3，返回可供访问的网络路径
            result.put("filePath", filePath);
            if (examinationService.insertLoad("上传的文件", filePath)) {
                result.put("data", 1);
            } else {
                result.put("data", 0);
            }

            return result;
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }
}
