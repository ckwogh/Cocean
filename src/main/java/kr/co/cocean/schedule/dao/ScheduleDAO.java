package kr.co.cocean.schedule.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.cocean.schedule.dto.ScheduleDTO;

@Mapper
public interface ScheduleDAO {

	List<String> getTeams();

//	List<ScheduleDTO> getCallender(String loginEmployeeID);

	void scheduleWrite(ScheduleDTO dto);

	List<HashMap<String, Object>> getCallenderEvents(int employeeID);

}
