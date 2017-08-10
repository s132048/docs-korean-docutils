=====================================================
 The reStructuredText_ Cheat Sheet: Syntax Reminders
=====================================================
:정보: 기본적인 부분은 <http://docutils.sf.net/rst.html>를 보면 된다.
:작가: 데이비드 굿져 <goodger@python.org>
:날짜: $Date$
:Revision: $Revision$
:설명: 이것은 "docinfo block" 로써, 도서 목록 리스트이다.

.. NOTE:: HTML로 읽고 있다면, input syntax 예제 대신에
   `<cheatsheet.txt>`_ 를 읽어라!

Section Structure
=================
Section 제목은 밑줄이거나 윗줄과 밑줄로 되어 있다.

Body Elements
=============
Grid table:

+--------------------------------+-----------------------------------+
| 문단은 왼쪽 끝처리를 하며,     | Literal block 앞에 "::"::         |
| 빈 줄에 의해 구분되어 진다.    |                                   |
|                                |     Indented                      |
|     Block quotes are indented. |                                   |
+--------------------------------+ or::                              |
| >>> print 'Doctest block'      |                                   |
| Doctest block                  | > Quoted                          |
+--------------------------------+-----------------------------------+
| | Line blocks는 줄 바꿈 및 들여쓰기를 유지한다. [new in 0.3.6]     |
| |     addresses, verse, and adornment-free lists에 유용하다.       |
|       긴 줄은 연속되는 줄로 묶을 수 있다.                          |
+--------------------------------------------------------------------+

Simple tables:

================  ============================================================
List Type         예 (`text source <cheatsheet.txt>`_ 에 있는 문법)
================  ============================================================
Bullet list       * 은 "-", "+", 또는 "*"를 사용한다.
Enumerated list   1. 은  "1.", "A)" 와 "(i)" 중에서 사용한다.
                  #. 또한 자동으로 열거되어 진다.
Definition list   Term 은 왼쪽 끝에 맞춰져 있다 : 선택적 분류
                      Definition은 들여쓰기가 되어지고, 사이에 비어있는 줄이 없다
Field list        :field name: field body
Option list       -o  option & description 사이에 적어도 2개의 칸이 있어야 한다.
================  ============================================================

================  ============================================================
Explicit Markup     예 (`text source`_ 에서 볼 수 있음)
================  ============================================================
Footnote          .. [1] 수동 넘버링,  [#] 자동 넘버링
                      또는 [*] 자동 심볼
Citation          .. [CIT2002] 인용.
Hyperlink Target  .. _reStructuredText: http://docutils.sf.net/rst.html
                  .. _indirect target: reStructuredText_
                  .. _internal target:
Anonymous Target  __ http://docutils.sf.net/docs/ref/rst/restructuredtext.html
Directive ("::")  .. image:: images/biohazard.png
Substitution Def  .. |substitution| replace:: like an inline directive
Comment           .. is anything else
Empty Comment      (빈 줄 앞 뒤에 있는 ".."는 들여쓰기된 문맥을 나누는 데 사용)
================  ============================================================

Inline Markup
=============
*emphasis*;
**strong emphasis**; 
`interpreted text`; 
`interpreted text with rol`:emphasis:; 
``inline literal text``; 
standalone hyperlink, http://docutils.sourceforge.net; 
named reference, reStructuredText_;
`anonymous reference`__; 
footnote reference, [1]_; 
citiation reference,[CIT2002]_; 
|substitution|; 
_`inline internal target`.


Directive Quick Reference
=========================
더 자세한 정보는 <http://docutils.sf.net/docs/ref/rst/directives.html>를 보면 된다.

================  ============================================================
Directive Name    설명 (Docutils 버젼은 [brackets]에 있음)
================  ============================================================
attention         구체적인 경고;  "caution", "danger",
                  "error", "hint", "important", "note", "tip", "warning"
admonition        일반적인 제목에 대한 경고: ``.. admonition:: By The Way``
image             ``.. image:: picture.png``; 많은 옵션이 가능하다.
figure            "image"와 같지만, 선택적인 제목과 범례를 가진다.
topic             ``.. topic:: Title``; 작은 섹션처럼 사용된다.
sidebar           ``.. sidebar:: Title``; 작고 유사한 문서처럼 사용된다.
parsed-literal    parse된 inline markup이 있는 literal block
rubric            ``.. rubric:: Informal Heading``
epigraph          class="epigraph"인 Block quote
highlights        class="highlights"인Block quote
pull-quote        class="pull-quote"인 Block quote
compound          복합 단락 [0.3.6]
container         Generic block-level container element [0.3.10]
table             제목이 있는 table을 만든다 [0.3.1]
list-table        같은 형태의 2단계 bullet list를 가지고 table을 만든다. [0.3.8]
csv-table         CSV 데이터로 테이블을 만든다. [0.3.4]
contents          목차를 만든다.
sectnum           자동으로 sections, subsections을 넘버링을 한다.
header, footer    문서 decorations을 만든다. [0.3.8]
target-notes      각각의 외부 타겟에 대해explicit footnote을 만든다.
math              수학 표기법 (LaTeX format으로 입력)
meta              HTML 관련 메타데이터
include           inline인 것처럼 외부 reST 파일을 읽는다.
raw               가공되지 않은채로 작가에 전달된 Non-reST data
replace           substitution 정의에 맞춰 텍스트 대체한다.
unicode           substitution 정의에 맞춰 유니코드 문자 코드 변환한다.
date              오늘의 날짜를 만든다.
class             다음 element에 "class"의 속성을 설정한다.
role              사용자 정의 interpreted text role을 만든다. [0.3.2]
default-role      default인 interpreted text role을 설정한다. [0.3.10]
title             메타 데이터 문서 제목을 설정한다. [0.3.10]
================  ============================================================

Interpreted Text Role Quick Reference
=====================================
더 자세한 정보는 <http://docutils.sf.net/docs/ref/rst/roles.html> 를 보면 된다.

================  ============================================================
Role Name         설명
================  ============================================================
emphasis          *emphasis* 와 같다.
literal           ``literal`` 와 같지만 backslash escapes를 처리한다.
math              수학 표기법 (LaTeX format으로 입력)
PEP               a numbered Python Enhancement Proposal에 대한 참조
RFC               a numbered Internet Request For Comments에 대한 참조
raw               non-reST data의 경우 직접적으로 사용 될 수 없다. (docs 참조) [0.3.6]
strong            **strong** 와 같다.
sub               서브스크립트
sup               슈퍼스크립트
title             제목 참조 (book, etc.); standard default role이다.
================  ============================================================
