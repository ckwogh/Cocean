package kr.co.cocean.aquarium.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.websocket.server.PathParam;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.cocean.aquarium.dto.AnimalDTO;
import kr.co.cocean.aquarium.dto.ClassficationDTO;
import kr.co.cocean.aquarium.dto.LogPlanDTO;
import kr.co.cocean.aquarium.service.AnimalService;
import kr.co.cocean.mypage.dto.LoginDTO;

@Controller
public class AnimalController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AnimalService service;
	
	@GetMapping(value = "/animal/list.go")
	public ModelAndView animalList() {
		
		ModelAndView mav = new ModelAndView("aquarium/animalList");
		
		// 코션친구들 리스트
		ArrayList<AnimalDTO> list = service.animalList();
		mav.addObject("list", list);
		
		return mav;
	}
	
	@GetMapping(value = "/animal/write.go")
	public ModelAndView animalWriteGo() {
		
		String branch = "1";
		
		ModelAndView mav = new ModelAndView("/aquarium/animalWrite");
		
		ArrayList<String> tankList = service.tankList(branch);
		mav.addObject("tankList", tankList);
		return mav;
	}
	
	@PostMapping(value = "/animal/write.do")
	public ModelAndView animalWrite(MultipartFile[] files, AnimalDTO param, RedirectAttributes rAttr) {
		logger.info("files : {}",files);
		logger.info("param : {}",param);
		return service.animalWrite(files,param, rAttr);
	}
	
	@GetMapping(value = "/animal/classficationPopup")
	public String classficationPopup() {
		return "aquarium/classfication";
	}
	
	@GetMapping(value = "/animal/classficationSearch")
	@ResponseBody
	public HashMap<String, Object> search(@RequestParam String keyword) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		ArrayList<ClassficationDTO> list = service.classficationSearch(keyword);
		result.put("list", list);
		return result;
	}
	
	
	@GetMapping(value = "/animal/detail.go")
	public ModelAndView animalDetailGo(@RequestParam int animalID, @RequestParam String nickname) {
		ModelAndView mav = new ModelAndView("aquarium/animalDetail");
		mav.addObject("animalID", animalID);
		mav.addObject("nickname", nickname);
		return mav;
	}
	
	@PostMapping(value = "/animal/detail.ajax")
	public String animalDetailAjax(@RequestParam String animalID, @RequestParam String con, Model model) {
		logger.info("animalID : {}",animalID);
		int intAnimalID = Integer.parseInt(animalID);
		logger.info("con : {}",con);
		return service.animalDetailAjax(intAnimalID, con, model);
	}
	
	@PostMapping(value = "/animal/detail.ajax.month")
	public String animalDetailAjaxMonth(@RequestParam String animalID, @RequestParam String con, Model model, @RequestParam String month) {
		logger.info("animalID : {}",animalID);
		int intAnimalID = Integer.parseInt(animalID);
		logger.info("con : {}",con);
		return service.animalDetailAjax(intAnimalID, con, month, model);
	}
	
	
	@PostMapping(value = "/animal/logplanWrite.go")
	@ResponseBody
	public HashMap<String, Object> logplanWrite(LogPlanDTO param, HttpSession session) {
		logger.info("param.con : {}",param.getContent());
		
		LoginDTO userInfo = (LoginDTO) session.getAttribute("userInfo");
		int employeeID = userInfo.getEmployeeID();
		param.setEmployeeID(employeeID);
		
		service.logplanWrite(param);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("result", "gg");
		return result;
	}

	@GetMapping(value ="/animal/classifi")
	public String getClassifi() {
		return "animal/classification";
	}
	
	@GetMapping(value = "/animal/organization")
	public String getOrganization() {
		return "personnel/organization";
	}
	
	
	
	
	
	
	
	
}
