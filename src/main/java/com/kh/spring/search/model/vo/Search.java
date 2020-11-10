package com.kh.spring.search.model.vo;

import java.util.ArrayList;

public class Search {
	private char searchType;
	private String search;
	private String searchall;
	private int sNum;

	public Search() {
	}

	public Search(char searchType, String search) {
		super();
		this.searchType = searchType;
		this.search = search;
	}

	public Search(char searchType, String search, String searchall, int sNum) {
		super();
		this.searchType = searchType;
		this.search = search;
		this.searchall = searchall;
		this.sNum = sNum;
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

	public int getsNum() {
		return sNum;
	}

	public void setsNum(int sNum) {
		this.sNum = sNum;
	}

	public String getSearchall() {
		return searchall;
	}

	public void setSearchall(String searchall) {
		this.searchall = searchall;
	}

	@Override
	public String toString() {
		return "Search [searchType=" + searchType + ", search=" + search + ", searchall=" + searchall + ", sNum=" + sNum
				+ "]";
	}



}
