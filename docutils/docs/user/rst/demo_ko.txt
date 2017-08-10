.. This is a comment. Note how any initial comments are moved by
   transforms to after the document title, subtitle, and docinfo.

================================
 reStructuredText Demonstration
================================

.. Above is the document title, and below is the subtitle.
   They are transformed from section titles after parsing.

--------------------------------
 Examples of Syntax Constructs
--------------------------------

.. bibliographic fields (which also require a transform):

:저자: 데이비드 굿져
:주소: 123 Example Street
          Example, EX  Canada
          A1B 2C3
:연락처: docutils-develop@lists.sourceforge.net
:공동 저자: Me, Myself, I
:조직: humankind
:날짜: $Date$
:상태: 진행중
:개정: $Revision$
:버젼: 1
:저작권: 이 문서는 공개 도메인이다. 원하는대로 복사, 변형, 재분배, 판매, 구매, 대여 등을 하여도 상관없다.
:분야: 일반적인 도서 목록 분야.
:분야2:
    일반적인 도서 목록 분야는 다음과 같은 다양한 요소를 포함할 수도 있다.


:Dedication:

    For Docutils users & co-developers.

:abstract:

    이 문서는 모든 기본적인  reStructuredText의 부분과 고급적인 부분들을 포함한 reStructuredText markup language의 예시이다.

.. meta::
   :keywords: reStructuredText, demonstration, demo, parser
   :description lang=en: A demonstration of the reStructuredText
       markup language, containing examples of all basic
       constructs and many advanced constructs.

.. contents:: Table of Contents
.. section-numbering::


Structural Elements
===================

Section Title
-------------

That's it, the text just above this line.

Transitions
-----------

여기에 transition에 있고:

---------

transition은 section을 나눈다.

Body Elements
=============

Paragraphs
----------

A paragraph.

Inline Markup
`````````````

단락들은 텍스트를 포함하고 inline markup( *emphasis*, **strong emphasis**, ``inline literals``, standalone hyperlinks(http://www.python.org), external hyperlinks (Python_), internal cross-references (example_), external hyperlinks with embedded URIs(`Python web site <http://www.python.org>`__), footnote references(manually numbered [1]_, anonymous auto-numbered [#]_, labeled auto-numbered [#label]_, or symbolic [*]_), citation references
([CIT2002]_), substitution references (|example|), and _`inline
hyperlink targets` (Targets_ )도 포함 할 수 있다.
문자 레벨의 inline markup 또한 가능하다.(*re*\ ``Structured``\ *Text*). 문제는 |problematic| text (processing errors에 의해 발생됨)에 의해 나타난다.

The default role for interpreted text은 `Title Reference`이다. 여기에 명시적인 interpreted text roles이 있다. : a PEP reference (:PEP:`287`); an
RFC reference (:RFC:`2822`); a :sub:`subscript`; a :sup:`superscript`;
:emphasis:`standard` :strong:`inline`
:literal:`markup`.

.. DO NOT RE-WRAP THE FOLLOWING PARAGRAPH!

inline literals에서 wrapping과 whitespace의 중요성을 테스트해보자:
``This is an example of --inline-literal --text, --including some--
strangely--hyphenated-words.  Adjust-the-width-of-your-browser-window
to see how the text is wrapped.  -- ---- --------  Now note    the
spacing    between the    words of    this sentence    (words
should    be grouped    in pairs).``

``--pep-references`` 옵션이 제공 된다면, PEP 258와 연결되는 링크가 여기에 있어야 한다.

Bullet Lists
------------

- A bullet list

  + Nested bullet list.
  + Nested item 2.

- Item 2.

  Paragraph 2 of item 2.

  * Nested bullet list.
  * Nested item 2.

    - Third level.
    - Item 2.

  * Nested item 3.

Enumerated Lists
----------------

1. Arabic numerals.

   a) lower alpha)

      (i) (lower roman)

          A. upper alpha.

             I) upper roman)

2. 1에서 시작하지 않는 리스트:

   3. Three

   4. Four

   C. C

   D. D

   iii. iii

   iv. iv

#. 리스트 아이템들은 자동으로 열거된다.

Definition Lists
----------------

용어
    Definition
용어 : 분류
    Definition paragraph 1.

    Definition paragraph 2.
용어
    Definition

Field Lists
-----------

:what: Field list는 field name과field body를 데이터 베이스의 레코드처럼 매       핑하고, 종종 확장한 문법의 일부분이 된다. 또한 Field list는 RFC 282       2 fields의 변형이다.

:how arg1 arg2:

    field marker는 colon, field name, colon 이다.

    field body는 field marker와 관련 있는 들여쓰기된 body elements를          하나 또는 그 이상 포함할 수도 있다.

Option Lists
------------

커맨드 라인 옵션 목록:

-a            커맨드 라인 옵션 "a"
-b file       옵션은 arguments와 자세한 설명을 가질 수 있다.
--long        옵션이 길어질 수 있다.
--input=file  긴 옵션은 arguments를 가질 수 있다.
--very-long-option
              설명은 다음 줄에서 시작될 수 있다.
  
              설명은 어디서 시작하던지 상관없이 다양한 body elements를 포               함할 수 있다.

-x, -y, -z    여러 옵션들은 "option group"이다.
-v, --verbose    흔히 볼 수 있는 짧고 긴 옵션
-1 file, --one=file, --two file
              arguments를 가진 여러 옵션.
/V            DOS/VMS 스타일의 옵션

옵션과 설명 사이에는 최소 2개의 공간이 있어야한다.


Literal Blocks
--------------

Literal blocks은 앞의 단락의 끝에서double-colon ("::")으로 나타내지고 들여쓰기 되어진다.::

    if literal_block:
        text = 'is left as-is'
        spaces_and_linebreaks = 'are preserved'
        markup_processing = None

또는 들여쓰기 없이 인용되어 질 수 있다.::

>> Great idea!
>
> Why didn't I think of that?

Line Blocks
-----------

| 이것은 line block이고, 빈 줄로 끝이난다. 
|     각각의 새로운 줄은 vertical bar ("|")로 시작한다.
|     줄 바꿈과 초기 들여쓰기는 유지된다.
| 많은 줄들의 부분으로 연속되는 줄들을 감싼다.;
  연속되는 줄들은 vertical bar 대신에 공간(space)을 사용한다.
|     연속되는 줄의 왼쪽 가장자리는 위의 텍스트들의 왼쪽 가장자리처럼 정렬될 필요는 없다.

| 이것은 두번째 line block이다.
|
| 내부적으로 빈 줄은 허용되지만, 반드시 "|"로 시작해야한다.

Take it away, Eric the Orchestra Leader!

    | A one, two, a one two three four
    |
    | Half a bee, philosophically,
    |     must, *ipso facto*, half not be.
    | But half the bee has got to be,
    |     *vis a vis* its entity.  D'you see?
    |
    | But can a bee be said to be
    |     or not to be an entire bee,
    |         when half the bee is not a bee,
    |             due to some ancient injury?
    |
    | Singing...

Block Quotes
------------

Block quotes는 들여쓰기된 body elements로 구성되어 있다.:

    My theory by A. Elk.  Brackets Miss, brackets.  This theory goes
    as follows and begins now.  All brontosauruses are thin at one
    end, much much thicker in the middle and then thin again at the
    far end.  That is my theory, it is mine, and belongs to me and I
    own it, and what it is too.

    -- Anne Elk (Miss)

Doctest Blocks
--------------

>>> print 'Python-specific usage examples; begun with ">>>"'
Python-specific usage examples; begun with ">>>"
>>> print '(cut and pasted from interactive Python sessions)'
(cut and pasted from interactive Python sessions)

Tables
------

여기에 간단한 도표가 있다.:

+------------------------+------------+----------+----------+
| Header row, column 1   | Header 2   | Header 3 | Header 4 |
| (header rows optional) |            |          |          |
+========================+============+==========+==========+
| body row 1, column 1   | column 2   | column 3 | column 4 |
+------------------------+------------+----------+----------+
| body row 2             | Cells may span columns.          |
+------------------------+------------+---------------------+
| body row 3             | Cells may  | - Table cells       |
+------------------------+ span rows. | - contain           |
| body row 4             |            | - body elements.    |
+------------------------+------------+----------+----------+
| body row 5             | Cells may also be     |          |
|                        | empty: ``-->``        |          |
+------------------------+-----------------------+----------+

=====  =====  ======
   Inputs     Output
------------  ------
  A      B    A or B
=====  =====  ======
False  False  False
True   False  True
False  True   True
True   True   True
=====  =====  ======

Footnotes
---------

.. [1] footnote는 body elements를 포함하고, 일관성 있게 적어도 3개의 공간으로 들여쓰기가 되어진다.

   여기는 footnote의 두번째 단락이다.

.. [#label] Footnotes는 수동적([1]_ 에서 한 것처럼)으로 넘버링 되어지거나   "#"-prefixed label을 사용해 자동적으로 넘버링 할 수 있다. 이 footnote는 label을 가지기 때문에 다양한 곳에서 ( a footnote reference ([#label]_) 와 a hyperlink reference(label_)) 참조되어질 수 있다.

.. [#] This footnote는"#"만을 사용해서 자동적이면서 특색없이 넘버링을 한다. 

.. [*] Footnote는 "*" label로 구체화된 심볼을 사용할 수도 있다. 여기에 다음 footnote에 대한 참조: [*]_ 가 있다.

.. [*] 이 footnote는 순서에 따라 다음 심볼을 보여준다.

.. [4] 여기에 참조되지 않은 footnote가 있다. 이는 존재하지 않는 footnote에 대한 참조이다.: [5]_.

Citations
---------

.. [CIT2002] Citation은 텍스트로 레이블된 footnote이다. Citiation은 footnote와는 별개로, 다르게 렌더링 되어 질수도 있다.

위에 대한 참조 [CIT2002]_, 와 [nonexistent]_ citation.

Targets
-------

.. _example:

이 단락은 the explicit "example" target에 의해 가리켜진다. 참조는 `Inline Markup`_ 아래에서 발견되어질 수 있다, `Inline hyperlink targets`_  역시 가능하다.



Section headers는 implicit target이고, 이름에 의해 참조되어진다. 
`Body Elements`_ 의 subsectiond인  Targets_ 를 봐라.

Explicit external targets는 "Python_" 과 같은 references에 삽입되어진다.

.. _Python: http://www.python.org/

Targets 간접적이고 익명적일 수도 있다. 그러므로 `this phrase`__ 는 또한 Targets_ section을 참조할 수도 있다.

__ Targets_

여기에 에러를 발생시키는 `hyperlink reference without a target`_ 이 있다.

Duplicate Target Names
``````````````````````

Section headers 또는 other implicit targets에 있는 Duplicate name은 "info" (level-1) 시스템 메시지를 발생 시킬 것이다. Explicit target에 있는 Duplicate names은 "warning" (level-2) 시스템 메시지를 발생 시킬 것이다.

Duplicate Target Names
``````````````````````

두 개의 "Duplicate Target Names" section headers가 있기 때문에, 이름에 의해 유일하게 어떤 것을 참조할 수는 없다.  이렇게 하면 (이처럼 `Duplicate Target Names`_ ), 에러가 발생한다.

Directives
----------

.. contents:: :local:

이는 많은 reStructuredText Directives들의 샘플일 뿐이다. 더 많은 부분을 알고 싶다면
http://docutils.sourceforge.net/docs/ref/rst/directives.html 를 참고하면 된다.

Document Parts
``````````````

"contents" directive 의 예는 이번 section(a local, untitled table of contents_)과 문서의 첫 부분(a document-wide `table of contents`_)에서 확인할 수 있다.

Images
``````

An image directive (클릭으로 하이퍼링크 참조가 가능):

.. image:: images/title.png
   :target: directives_

A figure directive:

.. figure:: images/title.png
   :alt: reStructuredText, the markup syntax

   Figure 는 caption이 있는 image이고 legend를 포함할 수도 있다.:

   +------------+-----------------------------------------------+
   | re         | Revised, revisited, based on 're' module.     |
   +------------+-----------------------------------------------+
   | Structured | Structure-enhanced text, structuredtext.      |
   +------------+-----------------------------------------------+
   | Text       | Well it is, isn't it?                         |
   +------------+-----------------------------------------------+

   이 단락 또한 legend의 일부이다.

Admonitions
```````````

.. Attention:: Directives at large.

.. Caution::

   Don't take any wooden nickels.

.. DANGER:: Mad scientist at work!

.. Error:: Does not compute.

.. Hint:: It's bigger than a bread box.

.. Important::
   - Wash behind your ears.
   - Clean up your room.
   - Call your mother.
   - Back up your data.

.. Note:: This is a note.

.. Tip:: 15% if the service is good.

.. WARNING:: Strong prose may provoke extreme mental exertion.
   Reader discretion is strongly advised.

.. admonition:: And, by the way...

   You can make up your own admonition too.

Topics, Sidebars, and Rubrics
`````````````````````````````

.. sidebar:: Sidebar Title
   :subtitle: Optional Subtitle

   여기가 사이드바이다. 사이드바는 본문의 흐름 밖에 있는 텍스트를 위해서 사용한다. 

   .. rubric:: 이것은 sidebar안에 있는 rubric이다.

   Sidebar는 테두리와 배경색이 있고 본문 옆에 나타난다.

.. topic:: Topic Title

   여기가 topic이다.

.. rubric:: 이것이 rubric이다.

Target Footnotes
````````````````

.. target-notes::

Replacement Text
````````````````

I recommend you try |Python|_.

.. |Python| replace:: Python, *the* best language around

Compound Paragraph
``````````````````

.. compound::

   이 단락은 literal block을 포함한다.::

       Connecting... OK
       Transmitting data... OK
       Disconnecting... OK
      
   그러므로 하나의 simple paragraph, 하나의 literal block 그리고 또 다른 하나의 simple paragraph로 구성되어 있다.  그럼에도 불구하고 의미론적으로는 *하나의* paragraph이다.

이러한 구성은 *compound paragraph* 라고 하고 "compound" directive와 같이 만들어진다.

Substitution Definitions
------------------------

An inline image (|example|) example:

.. |EXAMPLE| image:: images/biohazard.png

(Substitution definitions는 HTML source에서는 보이지 않는다.)

Comments
--------

Here's one:

.. Comments는 두 점과 하나의 공간으로 시작한다. footnote, hyperline targets, directives, 또는 substitution definitions의 문법을 제외하고는 어떤것이든 뒤에 올 수 있다.

   Double-dashes -- "--" -- must be escaped somehow in HTML output.

(Comment를 보려면 HTML source를 보자.)

Error Handling
==============

Processing 을 하면서 발생한 에러는 시스템 메시지를 발생시킨다. 

|*** Expect 6 errors (including this one). ***|

다음과 같은 6개의 메시지가 있어야하며 자동으로 만들어진 section인 "Docutils System Messages"가 있어야한다.

.. section should be added by Docutils automatically
