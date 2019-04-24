#!/usr/bin/env bash

cd "$(dirname "$0")"

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

vesion=$(ls /usr/local/bin | grep clang-format)
if [ -z "${vesion}" ]; then
	echo "${red}本脚本依赖clang-format  >= 7.0.0${reset}"
	echo "${green}使用brew install clang-format安装${reset}"
	exit
else
	vesion=$(clang-format --version)
	if [ ${vesion:21:1} -lt 7 ]; then
		echo "${red}本脚本依赖clang-format  >= 7.0.0${reset}"
		echo "${green}使用brew install clang-format安装${reset}"
		exit
	fi
fi

temp=".temp_for_clang_format"
header="header"
flag=0
clang_format=".clang-format"

function foo() {
	name=$1
	regex1="^//.*"
	regex2="/\*.*"
	regex3="\*.*"

	if [[ $(cat ${name} | head -n 1)x =~ ${regex1} ]]; then
		sed -i '' '1d' "${name}"
		foo ${name}
	fi

	if [[ $(cat ${name} | head -n 1)x =~ ${regex2} ]]; then
		sed -i '' '1d' "${name}"
		foo ${name}
	fi

	if [[ $(cat ${name} | head -n 1)x =~ ${regex3} ]]; then
		sed -i '' '1d' "${name}"
		foo ${name}
	fi
}

if [ -e ${temp} ]; then
	rm ${temp}
fi

if [ -e ${header} ]; then
	flag=1
else
	echo "/**" >${header}
	echo " * Copyright (C) 2018 Shanghai YOUWAN Science & Technology Co., Ltd." >>${header}
	echo " * All rights reserved." >>${header}
	echo " *" >>${header}
	echo " * This document is the property of Shanghai YOUWAN Science & Technology Co., Ltd." >>${header}
	echo " * It is considered confidential and proprietary." >>${header}
	echo " *" >>${header}
	echo " * This document may not be reproduced or transmitted in any form," >>${header}
	echo " * in whole or in part, without the express written permission of" >>${header}
	echo " * Shanghai YOUWAN Science & Technology Co., Ltd." >>${header}
	echo " */" >>${header}
fi

echo "---" >>${clang_format}
echo "BasedOnStyle:	LLVM" >>${clang_format}
echo "# 语言: None, Cpp, Java, JavaScript, ObjC, Proto, TableGen, TextProto" >>${clang_format}
echo "Language:	Cpp" >>${clang_format}
echo "# 访问说明符(public、private等)的偏移" >>${clang_format}
echo "AccessModifierOffset:	-4" >>${clang_format}
echo "# 开括号(开圆括号、开尖括号、开方括号)后的对齐: Align, DontAlign, AlwaysBreak(总是在开括号后换行)" >>${clang_format}
echo "AlignAfterOpenBracket:	Align" >>${clang_format}
echo "# 连续赋值时，对齐所有等号" >>${clang_format}
echo "AlignConsecutiveAssignments:	true" >>${clang_format}
echo "# 连续声明时，对齐所有声明的变量名" >>${clang_format}
echo "AlignConsecutiveDeclarations:	true" >>${clang_format}
echo "# 对齐逃脱换行(使用反斜杠换行)的反斜杠" >>${clang_format}
echo "AlignEscapedNewlines: Left" >>${clang_format}
echo "# 水平对齐二元和三元表达式的操作数" >>${clang_format}
echo "AlignOperands:	true" >>${clang_format}
echo "# 对齐连续的尾随的注释" >>${clang_format}
echo "AlignTrailingComments:	true" >>${clang_format}
echo "# 允许函数声明的所有参数在放在下一行" >>${clang_format}
echo "AllowAllParametersOfDeclarationOnNextLine:	true" >>${clang_format}
echo "# 允许短的块放在同一行" >>${clang_format}
echo "AllowShortBlocksOnASingleLine:	false" >>${clang_format}
echo "# 允许短的case标签放在同一行" >>${clang_format}
echo "AllowShortCaseLabelsOnASingleLine:	false" >>${clang_format}
echo "# 允许短的函数放在同一行: None, InlineOnly(定义在类中), Empty(空函数), Inline(定义在类中，空函数), All" >>${clang_format}
echo "AllowShortFunctionsOnASingleLine:	Empty" >>${clang_format}
echo "# 允许短的if语句保持在同一行" >>${clang_format}
echo "AllowShortIfStatementsOnASingleLine:	true" >>${clang_format}
echo "# 允许短的循环保持在同一行" >>${clang_format}
echo "AllowShortLoopsOnASingleLine:	false" >>${clang_format}
echo "# 总是在定义返回类型后换行(deprecated)" >>${clang_format}
echo "AlwaysBreakAfterDefinitionReturnType:	None" >>${clang_format}
echo "# 总是在返回类型后换行: None, All, TopLevel(顶级函数，不包括在类中的函数), " >>${clang_format}
echo "#   AllDefinitions(所有的定义，不包括声明), TopLevelDefinitions(所有的顶级函数的定义)" >>${clang_format}
echo "AlwaysBreakAfterReturnType:	None" >>${clang_format}
echo "# 总是在多行string字面量前换行" >>${clang_format}
echo "AlwaysBreakBeforeMultilineStrings:	false" >>${clang_format}
echo "# 总是在template声明后换行" >>${clang_format}
echo "AlwaysBreakTemplateDeclarations:	false" >>${clang_format}
echo "# false表示函数实参要么都在同一行，要么都各自一行" >>${clang_format}
echo "BinPackArguments:	false" >>${clang_format}
echo "# false表示所有形参要么都在同一行，要么都各自一行" >>${clang_format}
echo "BinPackParameters:	false" >>${clang_format}
echo "# 大括号换行，只有当BreakBeforeBraces设置为Custom时才有效" >>${clang_format}
echo "BraceWrapping:   " >>${clang_format}
echo "  # class定义后面" >>${clang_format}
echo "  AfterClass:	true" >>${clang_format}
echo "  # 控制语句后面" >>${clang_format}
echo "  AfterControlStatement: true	" >>${clang_format}
echo "  # enum定义后面" >>${clang_format}
echo "  AfterEnum: true	" >>${clang_format}
echo "  # 函数定义后面" >>${clang_format}
echo "  AfterFunction:	true" >>${clang_format}
echo "  # 命名空间定义后面" >>${clang_format}
echo "  AfterNamespace:	false" >>${clang_format}
echo "  # ObjC定义后面" >>${clang_format}
echo "  AfterObjCDeclaration:	false" >>${clang_format}
echo "  # struct定义后面" >>${clang_format}
echo "  AfterStruct:	true" >>${clang_format}
echo "  # union定义后面" >>${clang_format}
echo "  AfterUnion:	false" >>${clang_format}
echo "  # catch之前" >>${clang_format}
echo "  BeforeCatch:	true" >>${clang_format}
echo "  # else之前" >>${clang_format}
echo "  BeforeElse:	true" >>${clang_format}
echo "  # 缩进大括号" >>${clang_format}
echo "  IndentBraces:	false" >>${clang_format}
echo "# 在二元运算符前换行: None(在操作符后换行), NonAssignment(在非赋值的操作符前换行), All(在操作符前换行)" >>${clang_format}
echo "BreakBeforeBinaryOperators:	NonAssignment" >>${clang_format}
echo "# 在大括号前换行: Attach(始终将大括号附加到周围的上下文), Linux(除函数、命名空间和类定义，与Attach类似), " >>${clang_format}
echo "#   Mozilla(除枚举、函数、记录定义，与Attach类似), Stroustrup(除函数定义、catch、else，与Attach类似), " >>${clang_format}
echo "#   Allman(总是在大括号前换行), GNU(总是在大括号前换行，并对于控制语句的大括号增加额外的缩进), WebKit(在函数前换行), Custom" >>${clang_format}
echo "#   注：这里认为语句块也属于函数" >>${clang_format}
echo "BreakBeforeBraces:	Custom" >>${clang_format}
echo "# 在三元运算符前换行" >>${clang_format}
echo "BreakBeforeTernaryOperators:	true" >>${clang_format}
echo "# 在构造函数的初始化列表的逗号前换行" >>${clang_format}
echo "BreakConstructorInitializersBeforeComma:	true" >>${clang_format}
echo "# 每行字符的限制，0表示没有限制" >>${clang_format}
echo "ColumnLimit:	120" >>${clang_format}
echo "# 描述具有特殊意义的注释的正则表达式，它不应该被分割为多行或以其它方式改变" >>${clang_format}
echo "CommentPragmas:	'^ IWYU pragma:'" >>${clang_format}
echo "# 构造函数的初始化列表要么都在同一行，要么都各自一行" >>${clang_format}
echo "ConstructorInitializerAllOnOneLineOrOnePerLine:	false" >>${clang_format}
echo "# 构造函数的初始化列表的缩进宽度" >>${clang_format}
echo "ConstructorInitializerIndentWidth:	4" >>${clang_format}
echo "# 延续的行的缩进宽度" >>${clang_format}
echo "ContinuationIndentWidth:	4" >>${clang_format}
echo "# 去除C++11的列表初始化的大括号{后和}前的空格" >>${clang_format}
echo "Cpp11BracedListStyle:	false" >>${clang_format}
echo "# 继承最常用的指针和引用的对齐方式" >>${clang_format}
echo "DerivePointerAlignment:	false" >>${clang_format}
echo "# 关闭格式化" >>${clang_format}
echo "DisableFormat:	false" >>${clang_format}
echo "# 自动检测函数的调用和定义是否被格式为每行一个参数(Experimental)" >>${clang_format}
echo "ExperimentalAutoDetectBinPacking:	false" >>${clang_format}
echo "# 需要被解读为foreach循环而不是函数调用的宏" >>${clang_format}
echo "ForEachMacros:	[ foreach, Q_FOREACH, BOOST_FOREACH ]" >>${clang_format}
echo "# 对#include进行排序，匹配了某正则表达式的#include拥有对应的优先级，匹配不到的则默认优先级为INT_MAX(优先级越小排序越靠前)，" >>${clang_format}
echo "#   可以定义负数优先级从而保证某些#include永远在最前面" >>${clang_format}
echo "IncludeCategories: " >>${clang_format}
echo "  - Regex:	'^\"(llvm|llvm-c|clang|clang-c)/'" >>${clang_format}
echo "    Priority:	2" >>${clang_format}
echo "  - Regex:	'^(<|\"(gtest|isl|json)/)'" >>${clang_format}
echo "    Priority:	3" >>${clang_format}
echo "  - Regex:	'.*'" >>${clang_format}
echo "    Priority:	1" >>${clang_format}
echo "# 缩进case标签" >>${clang_format}
echo "IndentCaseLabels:	true" >>${clang_format}
echo "# 缩进宽度" >>${clang_format}
echo "IndentWidth:	4" >>${clang_format}
echo "# 函数返回类型换行时，缩进函数声明或函数定义的函数名" >>${clang_format}
echo "IndentWrappedFunctionNames:	false" >>${clang_format}
echo "# 保留在块开始处的空行" >>${clang_format}
echo "KeepEmptyLinesAtTheStartOfBlocks:	true" >>${clang_format}
echo "# 开始一个块的宏的正则表达式" >>${clang_format}
echo "MacroBlockBegin:	''" >>${clang_format}
echo "# 结束一个块的宏的正则表达式" >>${clang_format}
echo "MacroBlockEnd:	''" >>${clang_format}
echo "# 连续空行的最大数量" >>${clang_format}
echo "MaxEmptyLinesToKeep:	1" >>${clang_format}
echo "# 命名空间的缩进: None, Inner(缩进嵌套的命名空间中的内容), All" >>${clang_format}
echo "NamespaceIndentation:	Inner" >>${clang_format}
echo "# 使用ObjC块时缩进宽度" >>${clang_format}
echo "ObjCBlockIndentWidth:	4" >>${clang_format}
echo "# 在ObjC的@property后添加一个空格" >>${clang_format}
echo "ObjCSpaceAfterProperty:	false" >>${clang_format}
echo "# 在ObjC的protocol列表前添加一个空格" >>${clang_format}
echo "ObjCSpaceBeforeProtocolList:	true" >>${clang_format}
echo "# 在call(后对函数调用换行的penalty" >>${clang_format}
echo "PenaltyBreakBeforeFirstCallParameter:	19" >>${clang_format}
echo "# 在一个注释中引入换行的penalty" >>${clang_format}
echo "PenaltyBreakComment:	300" >>${clang_format}
echo "# 第一次在<<前换行的penalty" >>${clang_format}
echo "PenaltyBreakFirstLessLess:	120" >>${clang_format}
echo "# 在一个字符串字面量中引入换行的penalty" >>${clang_format}
echo "PenaltyBreakString:	1000" >>${clang_format}
echo "# 对于每个在行字符数限制之外的字符的penalty" >>${clang_format}
echo "PenaltyExcessCharacter:	1000000" >>${clang_format}
echo "# 将函数的返回类型放到它自己的行的penalty" >>${clang_format}
echo "PenaltyReturnTypeOnItsOwnLine:	60" >>${clang_format}
echo "# 指针和引用的对齐: Left, Right, Middle" >>${clang_format}
echo "PointerAlignment:	Right" >>${clang_format}
echo "# 允许重新排版注释" >>${clang_format}
echo "ReflowComments:	true" >>${clang_format}
echo "# 允许排序#include" >>${clang_format}
echo "SortIncludes:	true" >>${clang_format}
echo "# 允许排序using声明" >>${clang_format}
echo "SortUsingDeclarations: true" >>${clang_format}
echo "# 在C风格类型转换后添加空格" >>${clang_format}
echo "SpaceAfterCStyleCast:	false" >>${clang_format}
echo "# 在Template关键字后添加空格" >>${clang_format}
echo "SpaceAfterTemplateKeyword: true" >>${clang_format}
echo "# 在赋值运算符之前添加空格" >>${clang_format}
echo "SpaceBeforeAssignmentOperators:	true" >>${clang_format}
echo "# 开圆括号之前添加一个空格: Never, ControlStatements, Always" >>${clang_format}
echo "SpaceBeforeParens:	ControlStatements" >>${clang_format}
echo "# 在空的圆括号中添加空格" >>${clang_format}
echo "SpaceInEmptyParentheses:	false" >>${clang_format}
echo "# 在尾随的评论前添加的空格数(只适用于//)" >>${clang_format}
echo "SpacesBeforeTrailingComments:	1" >>${clang_format}
echo "# 在尖括号的<后和>前添加空格" >>${clang_format}
echo "SpacesInAngles:	false" >>${clang_format}
echo "# 在容器(ObjC和JavaScript的数组和字典等)字面量中添加空格" >>${clang_format}
echo "SpacesInContainerLiterals:	true" >>${clang_format}
echo "# 在C风格类型转换的括号中添加空格" >>${clang_format}
echo "SpacesInCStyleCastParentheses:	false" >>${clang_format}
echo "# 在圆括号的(后和)前添加空格" >>${clang_format}
echo "SpacesInParentheses:	false" >>${clang_format}
echo "# 在方括号的[后和]前添加空格，lamda表达式和未指明大小的数组的声明不受影响" >>${clang_format}
echo "SpacesInSquareBrackets:	false" >>${clang_format}
echo "# 标准: Cpp03, Cpp11, Auto" >>${clang_format}
echo "Standard:	Cpp11" >>${clang_format}
echo "# tab宽度" >>${clang_format}
echo "TabWidth:	4" >>${clang_format}
echo "# 使用tab字符: Never, ForIndentation, ForContinuationAndIndentation, Always" >>${clang_format}
echo "UseTab:	Never" >>${clang_format}

find . -name "*.h" >${temp}
find . -name "*.cpp" >>${temp}

while read line; do
	foo ${line}

	wait

	cp ${line} "${line}.ori"
	cat ${header} >"${line}"
	cat "${line}.ori" >>"${line}"
	rm "${line}.ori"

	clang-format -i ${line}
done <${temp}

if [ -e ${temp} ]; then
	rm ${temp}
fi

if [ ${flag} -eq 0 -a -e ${header} ]; then
	rm ${header}
fi

if [ -e ${clang_format} ]; then
	rm ${clang_format}
fi

wait
osascript -e 'tell application "Terminal" to quit' &
exit
