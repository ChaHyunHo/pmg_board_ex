package com.test.example.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.test.example.domain.BoardVO;
import com.test.example.domain.PageDTO;
import com.test.example.domain.SearchVO;
import com.test.example.domain.UserVO;
import com.test.example.service.BoardService;
import com.test.example.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private UserService userService;
	
	/**
	 * 리스트 화면을 보여주기위한 Get 방식 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list() throws Exception {
		return "board/list";
	}
	
	/**
	 * 게시글 등록
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView register(BoardVO vo) throws Exception {
		String page = "/board/dynamic/boardform";
		
		ModelAndView mav = new ModelAndView(page);;
		
		try {
			int result = boardService.insert(vo);
			if(result > 0) {
				mav.addObject("result", "success");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	/**
	 * 게시글 수정
	 * @return
	 * @throws Exception
	 */
	@PreAuthorize("principal.username == #vo.writer")
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView update(BoardVO vo, SearchVO search) throws Exception {
		String pageView = "/board/dynamic/boardform";
		ModelAndView mav = new ModelAndView(pageView);
		try {
			boardService.update(vo);
			
			search.setPage(search.getPage()); 					   // 현재 페이지 정보
			List<BoardVO> boardList =  boardService.listAll(search);
			List<BoardVO> noticeList = boardService.noticeList();  // 공지사항 리스트
		
			newLabel(boardList); // newLabel
			
			// 페이지 정보와 게시글 토탈수로 페이지계산식(pageDTO) 초기화 후 인스턴스 생성
			PageDTO pageDTO = new PageDTO(search, boardService.listTotalCount(search)); 
			
			/**
			 * order값이 null일 경우는 조회 조건이 없는 경우다
			 * 각 조회 버튼을 누르면 order에 값이 삽이되고 값이 있다면 정렬된 orderList객체를 불러온다.
			 */
			if(!(search.getOrder() == null || search.getOrder().equals(""))) {
				List<BoardVO> orderList = boardService.orderList(search);
				newLabel(orderList);   // 정렬 조건에서도 newLabel을 가지고 온다.
				boardList = orderList; // 해당 조건의 정렬된 리스트 객체를 boardList로 초기화 시켜준다.
			}
			
			mav.addObject("noticeList", noticeList);
			mav.addObject("boardList", boardList);
			mav.addObject("pageVO", search);                       // 페이지 정보(page, perPageNum)
			mav.addObject("pageDTO", pageDTO);                     // 페이지 계산식
			mav.addObject("searchTitle", search.getSearchTitle()); 
			mav.addObject("searchType", search.getSearchType());
			mav.addObject("orderVal", search.getOrder());
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	/**
	 * 게시글 삭제
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ModelAndView delete(BoardVO vo, SearchVO search) throws Exception {
		String page = "/board/dynamic/boardform";
		
		ModelAndView mav = new ModelAndView(page);;
		
		try {
			int result = boardService.delete(vo.getBno());
			
			if(result > 0) {
				search.setPage(search.getPage());
				List<BoardVO> boardList = boardService.listAll(search);
				
				List<BoardVO> noticeList = boardService.noticeList();  // 공지사항 리스트
				
				PageDTO pageDTO = new PageDTO(search, boardService.listTotalCount(search));
				
				/**
				 * 현재 페이지에 마지막 게시글 삭제시 앞페이지로 이동시킨다.
				 * 해당 페이지에 모든 게시글이 삭제됬을경우 앞페이지에 게시글이
				 * 있어도 보여지지 않는 경우 
				 */
				int totalNum = pageDTO.getTotal();
				
				/**
				 * 게시글 삭제시 토탈수를 10으로 나눈 나머지 값이 0일경우 해당
				 * 페이지에 게시글이 없다는 의미
				 */
				int resultNum = totalNum % 10;     
				
				if(resultNum == 0) {
					search.setPage(search.getPage() -1);      // 현재페이지에서 게시글이 없으므로 페이지 앞으로 이동
					boardList = boardService.listAll(search); // 페이지 정보가 바뀌므로 리스트객체도 새로 가지고옴
					
					/**
					 * order값이 null일 경우는 조회 조건이 없는 경우다
					 * 각 조회 버튼을 누르면 order에 값이 삽이되고 값이 있다면 정렬된 orderList객체를 불러온다.
					 */
					if(!(search.getOrder() == null || search.getOrder().equals(""))) {
						List<BoardVO> orderList = boardService.orderList(search);
						boardList = orderList; // 해당 조건의 정렬된 리스트 객체를 boardList로 초기화 시켜준다.
					}
				}
				
				// newLabel
				newLabel(boardList);
				
				mav.addObject("boardList", boardList);
				mav.addObject("noticeList", noticeList);
				mav.addObject("pageVO", search);
				mav.addObject("pageDTO", pageDTO);
				mav.addObject("searchTitle", search.getSearchTitle());
				mav.addObject("searchType", search.getSearchType());
				mav.addObject("orderVal", search.getOrder());
				mav.addObject("result", "success");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	/**
	 * 리스트jsp 페이지에서 ajax로 html을 셋팅
	 * 화면에 리스트객체를 내려주는 역할도 한다.
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/dynamic/boardlist/{page}", method = RequestMethod.GET)
	public ModelAndView dynamicListForm(SearchVO pagevo, @PathVariable("page") Integer page, Principal principal,
			HttpServletRequest req) throws Exception {
		String pageView = "/board/dynamic/boardform";
		ModelAndView mav = new ModelAndView(pageView);		
		HttpSession session = req.getSession();
		
		log.info(pagevo);
		log.info(pagevo.getPage());
		log.info(pagevo.getPerPageNum());
		log.info(pagevo.getPageStart());
		
		try {
			pagevo.setPage(page);
			List<BoardVO> boardList =  boardService.listAll(pagevo); // 일단 게시글
			
			List<BoardVO> noticeList = boardService.noticeList();  // 공지사항 리스트
			
			PageDTO pageDTO = new PageDTO(pagevo, boardService.listTotalCount(pagevo));
			
			/**
			 * 해당 조건은 현재 리스트 페이지에서 페이지 게시글 수(perPage) 변경시 
			 * 페이지의 정보가 변경되면서 게시글 목록에 데이터가 없어지는 현상을 방지한다.
			 */
			int realPage = pageDTO.getRealEnd();  		  // 페이지가 변경될경우 실제 계산된 마지막 페이지 정보
			
			if(page > realPage) {						  // 현재 페이지가 실제 페이지 보다 클경우 
				pageDTO.getPagevo().setPage(realPage);    // 현재 페이지를 마지막 페이지정보로 변경시켜 준다.  
				boardList = boardService.listAll(pagevo); // 페이지 정보가 변경되므로 리스트도 새로 가지고 온다.
			}
			
			/**
			 * order값이 null일 경우는 조회 조건이 없는 경우다
			 * 각 조회 버튼을 누르면 order에 값이 삽이되고 값이 있다면 정렬된 orderList객체를 불러온다.
			 */
			if(!(pagevo.getOrder() == null || pagevo.getOrder().equals(""))) {
				List<BoardVO> orderList = boardService.orderList(pagevo);
				boardList = orderList; // 해당 조건의 정렬된 리스트 객체를 boardList로 초기화 시켜준다.
			}
			
			newLabel(boardList); // newLabel
			
			/**
			 * 로그인시에 시큐리티에서 인증된 유저객체 정보를 가지고 와서
			 * 유저의 id를 통해 회원정보 객체를 가지고온다.
			 */
			if(principal != null) {
				UserVO user = userService.read(principal.getName());
				
				user.getAuthList().forEach(auth -> {
					session.setAttribute("sessionAuth", auth.getAuth());
				});
				
				session.setAttribute("sessionName", user.getName());					
				mav.addObject("idx", user.getIdx());
				mav.addObject("userName", user.getName());
			 }
			
			mav.addObject("boardList", boardList);
			mav.addObject("noticeList", noticeList);
			mav.addObject("pageVO", pagevo);
			mav.addObject("pageDTO", pageDTO);
			mav.addObject("searchTitle", pagevo.getSearchTitle());
			mav.addObject("searchType", pagevo.getSearchType());
			mav.addObject("orderVal", pagevo.getOrder());
			mav.addObject("tempIdx", pagevo.getMyBoardIdx());
			
		
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	/**
	 * 작성일 기준으로 하루까지 new 키워드 생성
	 * @param boardList
	 * @throws Exception
	 */
	private void newLabel(List<BoardVO> boardList) throws Exception {
		
		try {
			
			// new 키워드 
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			String today = simpleDateFormat.format(new Date());
			
			for(BoardVO board : boardList) {
				Calendar cal = Calendar.getInstance(); 
				
				cal.setTime(board.getRegisterDate());
				
				cal.add(Calendar.DATE, +1); // 작성일 + 하루 
				
				String registerAddOneDay = simpleDateFormat.format(cal.getTime());
			
				Date oneAfter = simpleDateFormat.parse(registerAddOneDay); // 작성일 기준 + 1일
			    
				Date todayParse = simpleDateFormat.parse(today); // 오늘 날짜 
				
				int compare = todayParse.compareTo(oneAfter); // 작성일 + 1  지금날짜 비교 
				
				if(compare == -1) {  // 작성일 + 1 날짜보다 현재날짜가 작다면 -1   
					board.setNewLabel(true); 	// new객체를 true로 준다. 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 게시글 등록 FORM 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dynamic/boardreg", method = RequestMethod.GET)
	public ModelAndView dynamicRegisterFrom(Principal principal) throws Exception {
		String page = "/board/dynamic/boardregisterform";
		ModelAndView mav = new ModelAndView(page);;
		try {
			if(principal != null) {
				UserVO user = userService.read(principal.getName());
				mav.addObject("idx", user.getIdx());
				mav.addObject("userName", user.getName());
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	
	
	/**
	 * 게시글 조회 FORM 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/dynamic/boardgetform", method = RequestMethod.GET)
	public ModelAndView dynamicGetForm(BoardVO vo, Integer page, SearchVO search, Principal principal) throws Exception {
		String pageView = "/board/dynamic/boardgetform";
		
		 log.info(search);
		
		ModelAndView mav = new ModelAndView(pageView);
		 try {
			 BoardVO board = boardService.read(vo.getBno());
			 
			 // 게시글 조회시 조회수 증가
			 boardService.updateView(vo.getBno());
			 
			 // 조회수 증가후 다시 상세 객체 가지고온다. 
			 board = boardService.read(vo.getBno());
			 
			 if(principal != null) {
					UserVO user = userService.read(principal.getName());
					log.info(user);
					log.info(user.getIdx());
					mav.addObject("idx", user.getIdx());
			 }
			 
			 mav.addObject("search", search);
			 mav.addObject("board", board);
			 mav.addObject("page", page);
			 mav.addObject("searchTitle", search.getSearchTitle());
			 mav.addObject("orderVal", search.getOrder());
		 }catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mav;
	}
	
	/**
	 * 게시글 수정 FORM 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/dynamic/boardupdateform", method = RequestMethod.GET)
	public ModelAndView dynamicUpdateForm(BoardVO vo, SearchVO search, Principal principal) throws Exception {
		String pageView = "/board/dynamic/boardupdateform";
		
		log.info(search);
		
		ModelAndView mav = new ModelAndView(pageView);
		 try {
			 BoardVO board = boardService.read(vo.getBno());  // 게시글 객체정보를 가지고온다
			 
			 PageDTO pageDTO = new PageDTO(search, boardService.listTotalCount(search));
			 
			 if(principal != null) {
				UserVO user = userService.read(principal.getName());
				mav.addObject("idx", user.getIdx());
			 }
			 
			 mav.addObject("pageDTO", pageDTO);
			 mav.addObject("search", search);
			 mav.addObject("board", board);
			 mav.addObject("page", search.getPage());
			 mav.addObject("searchTitle", search.getSearchTitle());
			 mav.addObject("searchType", search.getSearchType());
			 mav.addObject("orderVal", search.getOrder());
		 }catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mav;
	}

}
