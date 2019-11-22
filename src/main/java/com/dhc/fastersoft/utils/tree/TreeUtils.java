package com.dhc.fastersoft.utils.tree;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONArray;

/**
 * 将记录list转化为树形list
 * 基于BaseTreeGid类的转换
 *
 */
public class TreeUtils {

	/**
	 * 格式化list为树形list
	 * @param list
	 * @param falg true 表示全部展开，其他 表示不展开
	 * @return
	 */
	public static <T extends BaseTreeGrid> List<T> formatTree(List<T> list, Boolean flag) {

		List<T> nodeList = new ArrayList<T>();  
		for(T node1 : list){  
		    boolean mark = false;  
		    for(T node2 : list){  
		        if(node1.getParentId()!=null && node1.getParentId().equals(node2.getId())){ 
		        	node2.setLeaf(false);
		            mark = true;  
		            if(node2.getChildren() == null) {
		            	node2.setChildren(new ArrayList<BaseTreeGrid>());  
		            }
		            node2.getChildren().add(node1); 
		            if (flag) {
		            	//默认已经全部展开
		            } else{
		            	node2.setExpanded(false);
		            }
		            break;  
		        }  
		    }  
		    if(!mark){  
		        nodeList.add(node1);   
		        if (flag) {
	            	//默认已经全部展开
	            } else{
	            	node1.setExpanded(false);
	            }
		    }  
		}
		return nodeList;
	}
	
	public static void main(String[] args) {
		List<BaseTreeGrid> list = new ArrayList<BaseTreeGrid>();
		BaseTreeGrid root1 = new BaseTreeGrid();
		root1.setId("1");
		BaseTreeGrid child1 = new BaseTreeGrid();
		child1.setId("11");
		child1.setParentId("1");
		BaseTreeGrid child11 = new BaseTreeGrid();
		child11.setId("111");
		child11.setParentId("11");
		BaseTreeGrid root2 = new BaseTreeGrid();
		root2.setId("2");
		BaseTreeGrid child2 = new BaseTreeGrid();
		child2.setId("21");
		child2.setParentId("2");
		list.add(root1);
		list.add(child1);
		list.add(child11);
		list.add(root2);
		list.add(child2);
		List<BaseTreeGrid> treelist = formatTree(list, false);
		String json = JSONArray.toJSONString(treelist);
		System.out.println(json);
	}
	
}
