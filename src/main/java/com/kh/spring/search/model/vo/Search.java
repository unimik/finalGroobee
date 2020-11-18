package com.kh.spring.search.model.vo;

import java.util.ArrayList;
import java.util.Arrays;

public class Search {
	private char searchType;
	private String search;
	private String searchall;
	private int sNum;
	private String[] sarr;
	private int[] barr;
	
	public Search() {
	}

	public Search(char searchType, String search) {
		super();
		this.searchType = searchType;
		this.search = search;
	}


	public Search(char searchType, String[] sarr) {
		super();
		this.searchType = searchType;
		this.sarr = sarr;
	}
	
	
	public Search(char searchType, String search, int[] barr) {
		super();
		this.searchType = searchType;
		this.search = search;
		this.setBarr(barr);
	}

	
	
	public Search(String[] sarr, int[] barr) {
		super();
		this.sarr = sarr;
		this.barr = barr;
	}

	public Search(char searchType, String search, String searchall, int sNum, String[] sarr) {
		super();
		this.searchType = searchType;
		this.search = search;
		this.searchall = searchall;
		this.sNum = sNum;
		this.sarr = sarr;
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


	public String[] getSarr() {
		return sarr;
	}

	public void setSarr(String[] sarr) {
		this.sarr = sarr;
	}

	@Override
	public String toString() {
		return "Search [searchType=" + searchType + ", search=" + search + ", searchall=" + searchall + ", sNum=" + sNum
				+ ", sarr=" + Arrays.toString(sarr) + "]";
	}

	public int[] getBarr() {
		return barr;
	}

	public void setBarr(int[] barr) {
		this.barr = barr;
	}

	


}
