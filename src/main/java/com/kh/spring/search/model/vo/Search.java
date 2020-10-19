package com.kh.spring.search.model.vo;

import java.util.ArrayList;

public class Search {
	private char searchType;
	private String search;
	
	public Search() {
	}
	
	public Search(char searchType, String search) {
		super();
		this.searchType = searchType;
		this.search = search;
	}

	
	public char getSearchType() {
		return searchType;
	}
	public void setSearchType(char searchType) {
		this.searchType = searchType;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}

	
	@Override
	public String toString() {
		return "Search [searchType=" + searchType + ", search=" + search  +"]";
	}

	
	

	
}
