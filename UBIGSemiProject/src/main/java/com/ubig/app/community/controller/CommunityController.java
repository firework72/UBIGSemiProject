package com.ubig.app.community.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ubig.app.community.service.CommunityService;
import com.ubig.app.vo.community.BoardVO;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService communityService;

    @GetMapping("/list")
    public String list(Model model) {
        // List<BoardVO> list = communityService.getBoardList();
        // model.addAttribute("list", list);
        return "community/list";
    }
}
