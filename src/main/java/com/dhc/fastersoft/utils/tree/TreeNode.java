package com.dhc.fastersoft.utils.tree;

import java.util.List;

public interface TreeNode<T> {

	boolean isChildFrom(T node);

	boolean isBrother(T node);
	
	void addChildNode(T node);
	
	List<T> getChildNodes();
}