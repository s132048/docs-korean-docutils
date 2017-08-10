=============================
 reStructuredText 명령어
=============================
:저자: 데이비드 구저
:연락처: docutils-develop@lists.sourceforge.net
:리비전: $리비전$
:날짜: $날짜$
:저작권: 이 문서는 퍼블릭 도메인에 속한다.

.. contents::

이 문서는 레퍼런스 reStructuredText 파서에 구현되어 있는 명령어를 기술한다.

명령어는 아래와 같은 문법을 갖는다. ::

    +------+----------------------+
    | ".. "| 명령어 타입 "::" 명령어  |
    +------+ 블럭                  |
           |                      |
           +----------------------+

명령어는 명확한 마크업(두개의 마침표와 공백)으로 시작해 뒤이어 명령어 타입과 명령어 마커(두개의 콜론)이 온다.
명령어 마커 뒤로 명령어 블럭이 오고 이어지는 모든 들여쓴 라인들을 포함한다.
명령어 블럭은 인수, 옵션(필드 리스트), 목차(순서에 맞추어) 중 어느 것이든 나타 것으로 분할된다.
문법적인 세부사항들은 `reStructuredText 마크업 설명서`_ 의 `명령어`_ 부분을 참고하라.

"doctree elements" (문서계층 요소; XML DTD 포괄 식별자 ) 리스트 아래의 기술들은 개별 명령어들에 대응된다.
요소의 계층에 대한 세부사항들은 `Docutils 문서계층`_ 과 `Docutils 포괄 DTD`_ XML 문서 타입 정의를 참고하라.
명령어 실행에 대한 세부사항들은 `reStructuredText 명령어 생성`_ 을 참고하라.

.. _명령어: restructuredtext_ko.html#directives
.. _reStructuredText 마크업 설명서: restructuredtext_ko.html
.. _Docutils 문서계층: ../doctree.html
.. _Docutils 포괄 DTD: ../docutils.dtd
.. _reStructuredText 명령어 생성:
   ../../howto/rst-directives_ko.html


--------------------
 경고 (Admonitions)
--------------------

.. 개정판 웹스터 완본 사전으로 부터 경고(Admonition)의 사전적 의미 (1913) [web1913]:
   Admonition
      Gentle or friendly reproof; counseling against a fault or
      error; expression of authoritative advice; friendly caution
      or warning.

      Syn: {Admonition}, {Reprehension}, {Reproof}.

      Usage: Admonition is prospective, and relates to moral delinquencies;
             its object is to prevent further transgression.

.. _attention:
.. _caution:
.. _danger:
.. _error:
.. _hint:
.. _important:
.. _note:
.. _tip:
.. _warning:

특정 경고
============

:명령어 타입: "attention", "caution", "danger", "error", "hint",
                  "important", "note", "tip", "warning", "admonition"
:Doctree 요소: attention, caution, danger, error, hint, important,
                   note, tip, warning, admonition_, title
:명령어 인수: None.
:명령어 옵션: `:class:`_, `:name:`_
:명령어 내용: 구성요소로 해석됨.

경고는 특별히 "토픽"으로 강조되어 일반적인 구성요소가 나타날 수 있는 곳이면 어디든 나타날 수 있다.
임의의 구성요소를 포함하며 일반적으로 경고는 타입에 맞는 타이틀과 함께 문서 내부에 오프셋 블럭으로 구현된다.
때때로 블럭에 윤곽이나 음영이 생긴다. 예시 ::

    .. DANGER::
       살인 토끼를 주의하세요!

이 명령어는 아래와 같이 구현될 것이다. ::

    +------------------------+
    |        !DANGER!        |
    |                        |
    |    살인 토끼를 주의하세요!   |
    +------------------------+

아래의 경고 명령어들이 구현되어 있다.

- attention
- caution
- danger
- error
- hint
- important
- note
- tip
- warning

명령어 표시 바로 뒤에 오는 모든 텍스트는 명령어 블럭으로 해석된고 일반 구성요소로 파싱된다.
(동일한 라인에 있거나 이어지는 라인에 들여쓰여 있다면) 예를 들어 아래의 "note" 경고 명령어는
하나의 문단과 두개의 항목을 갖는 글머리 기호 목록을 포함한다. ::

    .. note:: 이것은 note 경고이다.
       이것은 첫문단의 두번째 줄이다.

       - note는 들여쓴 모든 구성요소를
         포함한다.
       - 글머리 기호 목록을 포함한다.


포괄 경고
==================

:명령어 타입: "admonition"
:Doctree 요소: admonition_, title
:명령어 인수: One, required (admonition title)
:명령어 옵션: 가능하다. 아래 내용을 보자.
:명령어 내용: 구성요소로 해석됨.

이것은 포괄적이고 표제된 경고이다. 표제는 저자가 원하는 것은 모두 가능하다.

저자에 의해 지정된 표제는 유효한 식별자 형태로 변환되어 `"클래스"`_ 객체값으로도 사용된다.
(down-cased; 영숫자가 아닌 문자는 하이픈으로 변환된다; "admonition-"  )
예를 들어, 아래와 같은 경고는 ::

    .. admonition:: 경고 예시...

       작성자가 원하는 대로 경고를 만들 수 있다.

위의 예시를 pseudo-XML 로 나타내면 다음과 같은 문서계층이 된다. ::

    <document source="test data">
        <admonition classes="admonition-and-by-the-way">
            <title>
                경고 예시...
            <paragraph>
                작성자가 원하는 대로 경고를 만들 수 있다.

`공통 옵션`_ 이 인식된다:

``class`` : 텍스트
    산출된 `"클래스"`_ 객체값을 무시한다.

``name`` : 텍스트
  경고요소의 `"name"`_ 객체에 텍스트를 추가한다.

------------------
 이미지 (images)
------------------

이미지 명령어에는 "image"와 "figure" 가 있다.


이미지
=======

:명령어 타입: "image"
:Doctree 요소: image_
:명령어 인수: 1개, 필수 (이미지 URI).
:명령어 옵션: 가능
:멍령어 내용: None.

"image" 단순한 사진이다. ::

    .. image:: 사진.png

인라인 이미지는 `대체 정의`_ 내부의 "image" 명령어로 정의될 수 있다

이미지 소스파일의 URI는 명령어 인수에 명시된다. 이미지 URI는 하이퍼링크의 대상으로서
들여쓰여진 텍스트 블럭 바로 뒤에 오거나
링크 블럭에 여러개의 줄이 있다면
The URI for the image source file is specified in the directive
argument.  As with hyperlink targets, the image URI may begin on the
same line as the explicit markup start and target name, or it may
begin in an indented text block immediately following, with no
intervening blank lines.  If there are multiple lines in the link
block, they are stripped of leading and trailing whitespace and joined
together.

선택적으로 이미지 링크 블럭은 _`이미지 옵션` 이라는 단순 필드 리스트를 포함할 수 있다. 예시 ::

    .. image:: picture.jpeg
       :height: 100px
       :width: 200 px
       :scale: 50 %
       :alt: alternate text
       :align: right

아래의 옵션들이 인식된다.:

``alt`` : 텍스트
    대체 텍스트 (alternate test): 이미지에 대한 짧은 설명으로 이미지를 나타낼 수 없는
    어플리케이션에 의해 출력되거나 시각장애인 사용자를 위한 어플리케이션에 의해 음성으로 출력한다.

``height`` : `길이`_
    권장되는 이미지의 높이이다. 공간을 확보하거나 이미지를 수직방향으로 조정하기 위해 사용된다.
    "scale" 옵션도 명시된 경우 "height" 옵션과 결합된다.
    예를 들어 "height" 가 200px, "scale" 값이 50인 경우 "scale" 옵션을 사용하지 않고 100px 의 "height" 값을 갖는 것과 같다.

``width`` : 이미지가 들어갈 행에서 차지할 `길이`_ 또는  `백분율`_
    이미지의 너비가 된다. 이미지의 공간을 확보하거나 수평방향으로 조정하는데 사용된다.
    "scale" 옵션이 명시된 경우 "height" 옵션과 같은 방식으로 적용된다.

    .. _길이: restructuredtext_ko.html#length-units
    .. _백분율: restructuredtext_ko.html#percentage-units

``scale`` : 정수 백분율 (% 기호는 선택사항)
    이미지의 균일 환산계수가 된다. 디폴트는 100%로 스케일링 되지 않는다.

    "height" 와 "width" 옵션을 명시하지 않은 경우, `파이썬 이미징 라이브러리`_ 가 사용된다.
    (파이썬 이미징 라이브러리가 설치되어 있고 이를 지원하는 이미지인 경우 )

``align`` : "top", "middle", "bottom", "left", "center", or "right"
    이미지의 정렬에 사용되며 HTML의 ``<img>`` 태그의 "align" 객체와 동일하고
    "text-align" CSS 요소에 대응한다.
    "top", "middle", "bottom" 값은 이미지의 수직방향 정렬을 결정한다.
    (text의 바탕선에 대한 정렬); 인라인 이미지인 경우에만 쓸모가 있다.
    The values "top", "middle", and "bottom"
    "left", "center", "right" 값은 이미지의 수평방향 정렬을 결정한다.
    이미지 주변에 텍스트가 들어갈 수 있게 한다.
    세부적인 적용은 브라우저나 렌더링 소프트웨어에 따라 다르게 나타날 수 있다.

``target`` : 텍스트 (URI 혹은 레퍼런스)
    이미지를 하이퍼링크 레퍼런스로 만들어 클릭할 수 있게 한다.
    옵션 인수는 URI(상대 혹은 절대)나 `레퍼런스명`_ 이 된다.
    레퍼런스명은 ```레퍼런스명`_`` 과 같이 밑줄이 붙는다.

공통 옵션은 `:class:`_ 와 `:name:`_ 가 있다.

.. _대체 정의: restructuredtext_ko.html#substitution-definitions


도표
======

:명령어 타입: "figure"
:Doctree 요소: figure_, image_, caption_, legend_
:명령어 인수: 1개, 필수 (이미지 URI).
:명령어 옵션: 가능.
:명령어 내용: 도표 캡션이나 범례로 해석됨.

도표 (figure)는 `이미지 옵션`_ 을 포함하는 `이미지`_ 데이터로 구성되며
선택적으로 캡션(하나의 문단)이나 범례(임의의 구성요소)를 추가할 수 있다.
페이지 기반 출력 미디어에서 도표는 페이지 레이아웃에 맞춰 다른 위치에 나타날 수 있다.
::

    .. figure:: picture.png
       :scale: 50 %
       :alt: 묻혀 있는 보물로 향하는 지도

       이것은 도표의 캡션이다. (간단한 문단)

       범례는 캡션 뒤에 오는 모든 요소들을 포함한다.
       여기서는 이 문단과 이어서 아래의 표가 범례가 된다.

       +-----------------------+-----------------------+
       | 기호                   | 의미                   |
       +=======================+=======================+
       | .. image:: tent.png   | 캠프장                  |
       +-----------------------+-----------------------+
       | .. image:: waves.png  | 호수                   |
       +-----------------------+-----------------------+
       | .. image:: peak.png   | 산                    |
       +-----------------------+-----------------------+

캡션이 되는 문단과 범례 앞에는 공백행이 반드시 있어야 한다.
캡션 없이 범례를 명시하고자 하는 경우 캡션 자리에 빈 코멘트 ("..")를 사용한다.

"figure" 명령어는 "image" 명령어의 모든 옵션을 지원한다. `이미지 옵션`_ 을 참고하라.
이 옵션("align" 제외)들은 도표가 가진 이미지에 적용된다.

``align`` : "left", "center", or "right"
    도표의 수평방향 정렬에 사용되며 이미지 주변에 텍스트가 들어가게 한다.
    세부적인 적용은 브라우저나 렌더링 소프트웨어에 따라 다르게 나타날 수 있다.

추가로 아래의 옵션들이 있다.

``figwidth`` : "image", 행에서 차지할 `길이`_ 또는 `백분율`_
    도표의 너비.
    도표가 사용할 수평방향 공간을 한정한다.
    이미지의 자체적인 너비가 사용된 경우 "image"의 특정값 허용된다.
    (`파이썬 이미징 라이브러리`_ 가 요구된다.)
    이미지 파일을 찾을 수 없거나 필요한 소프트웨어를 사용할 수 없는 경우
    이 옵션은 무시된다.

    "figure" doctree 요소의 "width" 객체를 설정하자.

    이 옵션은 도표의 포함된 이미지를 스케일링하지 않는다.
    ;스케일링이 필요하다면 `이미지`_ 의 "width" 옵션을 사용한다.

        +---------------------------+
        |        figure             |
        |                           |
        |<------ figwidth --------->|
        |                           |
        |  +---------------------+  |
        |  |     image           |  |
        |  |                     |  |
        |  |<--- width --------->|  |
        |  +---------------------+  |
        |                           |
        |도표 캡션은 이 너비에서 끝나야한다. |
        |                           |
        +---------------------------+

``figclass`` : 텍스트
    도표의 `"클래스"`_ 객체값을 설정한다.
    아래의 `클래스`_ 명령어를 참고하라.
    Set a `"클래스"`_ attribute value on the figure element.  See the
    class_ directive below.

.. _파이썬 이미징 라이브러리: http://www.pythonware.com/products/pil/


---------------
 구성요소
---------------

토픽
=====

:명령어 타입: "topic"
:Doctree 요소: topic_
:명령어 인수: 1, 필수 (토픽의 표제).
:명령어 옵션: `:class:`_, `:name:`_
:명령어 내용: Interpreted as the topic body.

토픽(topic)은 표제가 있는 블럭 인용이나 하위 섹션을 포함하지 않는 독립 섹션과 유사하다.
문맥에서 벗어난 독립적인 아이디어를 나타내기 위해 "topic" 명령어를 사용한다.
토픽은 섹션이나 전이가 나타날 수 있는 곳이면 어디든 올 수 있다.
구성 요소와 토픽은 내포된 토픽을 포함하지 않을 수 있다.

명령어의 단일 인수는 토픽의 표제로 해석되고 그 다음 행은 공백행이 되어야 한다.
뒤이어 오는 모든 행들은 토픽의 내용이 되고 구성요소로 해석된다. 예시 ::

    .. topic:: 토픽 표제

        이어서 오는 들여쓴 행들은 토픽의 내용을 구성한다.
        이 행들은 구성요소로 해석된다.


사이드바
=======

:명령어 타입: "sidebar"
:Doctree 요소: sidebar_
:명령어 인수: 1개, 필수 (사이드바 표제).
:명령어 옵션: 가능 (아래 내용 참조).
:명령어 내용: 사이드바의 내용으로 해석됨.

사이드바는 미니어처와 같이 문서 내부에 나타나는 병렬 문서로 문서와 관련되거나 레퍼런스가 되는 자료를 제공한다.
사이드바는 보통 구분선으로 나누어지며 페이지의 가장자리에 떠있다.;
문서의 본문이 되는 텍스트가 주변을 지날 수 있다.
사이드바는 초각주(super-footnotes)가 될 수도 있다.;
사이드바의 내용이 문서의 본문이 갖는 흐름에서 벗어날 수 있다.

사이드바는 섹션이나 전이가 나타날 수 있는 곳이면 어디든 올 수 있다.
사이드바를 포함한 구성요소들은 내포된 구성요소를 포함하지 않을 수 있다.

명령어의 단일 인수는 사이드바의 표제로 해석되고 그 뒤로 부제 옵션(아래 참조)이 올 수 있다.
;그 다음 행은 반드시 공백행이 되어야 한다.
뒤이어 오는 모든 행들은 구성요소로 해석된다. 예시 ::

    .. sidebar:: 사이즈바 표제
       :subtitle: 사이드바 부제 (선택사항)

       이어서 오는 들여쓴 행들은 토픽의 내용을 구성한다.
       이 행들은 구성요소로 해석된다.

아래의 옵션이 인식된다.:

``subtitle`` : 텍스트
    사이드바의 부제.

공통 옵션으로 `:class:`_ 와 `:name:`_ 가 있다.


라인 블럭
==========

.. admonition:: 더 이상 사용하지 않는다.

   "line-block" 명령어는 이제 사용하지 않는다.
   대신 `라인 블럭 문법`_ 을 사용한다.

   .. _라인 블럭 문법: restructuredtext.html#line-blocks

:명령어 타입: "line-block"
:Doctree 요소: line_block_
:명령어 인수: None.
:명령어 옵션: `:class:`_, `:name:`_
:명령어 내용: 라인 블럭의 본문이 된다.

행이 바뀌면서 기존의 들여쓰기가 중요해지고 인라인 마크업이 지원될 때 "line-block" 명령어는 요소를 구성한다.
이는 자동으로 들여쓰기가 되지 않고 고정 너비 타이프라이터 서체 대신 일반적인 세리프로 구현되어
`파싱된 리터럴 블럭`_ 의 다른 형태가 된다.
(line-block 명령어는 들여쓴 라인 블럭을 가진 채로 인용 블럭을 시작한다)
라인 블럭은 주소 블럭이나 절(노래 가사나 시)처럼 행의 구조가 중요할 때 유용하게 쓰인다.
예를 들어 아래 고전작품과 같이 ::

    "To Ma Own Beloved Lassie: A Poem on her 17th Birthday", by
    Ewan McTeagle (for Lassie O'Shea):

        .. line-block::

            Lend us a couple of bob till Thursday.
            I'm absolutely skint.
            But I'm expecting a postal order and I can pay you back
                as soon as it comes.
            Love, Ewan.



.. _parsed-literal:

파싱된 리터럴 블럭
====================

:명령어 타입: "parsed-literal"
:Doctree 요소: literal_block_
:명령어 인수: None.
:명령어 옵션: `:class:`_, `:name:`_
:명령어 내용: 리터럴 블럭의 본문이 된다.

일반적인 리터럴 블럭과 다르게 "파싱된 리터럴" 명령어는 텍스트가 인라인 마크업으로 파싱되었을 때 리터럴 블럭을 구성한다.
고정 너비 타이프라이터 서체로 구현된다는 점에서 일반적인 라인 블럭과 유사하고 `라인 블럭`_ 의 다른 형태가 된다.
파싱된 리터럴 블럭은 코드 예제에 하이퍼링크를 추가할 때 유용하다.

파싱된 리터벌 블럭에서는 인라인 마크업이 인식되고 파싱되는 과정에서 보존되지 않기 때문에 텍스트에 주의해야 한다.
들여쓰기가 없는 파싱을 막기 위해 백슬래시 이스케이프가 필요할 수 있다.
파서를 통해 마크업 문자들이 제거되기 때문에 수직방향 정렬에도 신경써야 한다.
파싱된 "ASCII art" 는 까다로울 수 있고 추가적인 공백이 필요할 수 있다.

예를 들어, 아래 내용의 모든 요소명은 링크되어 있다. ::

    .. parsed-literal::

       ( (title_, subtitle_?)?,
         decoration_?,
         (docinfo_, transition_?)?,
         `%structure.model;`_ )

코드
========

:명령어 타입: "code"
:Doctree 요소: literal_block_, `inline elements`_
:명령어 인수: 1개, 선택 (형식 언어).
:명령어 옵션: name, class, number-lines.
:명령어 내용: Becomes the body of the literal block.
:배열 설정: syntax_highlight_.

(Docutils 0.9에 신규 등록)

"code" 명령어는 리터럴 블럭을 구성한다.
코드의 언어가 명시된 경우 내용은 Pygments_ 문법 하이라이터의 의해 파싱되고
토큰은 내포된 `인라인 요소`_ 에 클래스 인수(문법 분류에 따라)와 함께 저장된다.
실제 하이라이트는 스타일 시트가 요구된다.
(예를 들어 `generated by Pygments`__ 가 있다. `sandbox/stylesheets`__ 에서 예시를 볼 수 있다.)

파싱은 syntax_highlight_ 배열 설정과 커맨드 라인 옵션으로 종료되거나
명령어 인수 대신 `:class:`_ 옵션으로 형식 언어를 지정한 경우 종료될 수 있다.
형식 언어가 `지원 언어 및 마크업 포맷`_ 에 속하지 않거나 Pygments_ 가 설치되지 않았을 때 파싱은 경고를 회피한다.

인라인 코드를 위해 `"코드" 기능`_ 을 사용한다.

__ http://pygments.org/docs/cmdline/#generating-styles
__ http://docutils.sourceforge.net/sandbox/stylesheets/
.. _Pygments: http://pygments.org/
.. _syntax_highlight: ../../user/config.html#syntax-highlight
.. _지원 언어 및 마크업 포맷: http://pygments.org/languages/
.. _"코드" 기능: roles.html#code


아래의 옵션이 인식된다.

``number-lines`` : [행의 번호로 시작]
    행 번호로 모든 행의 앞에 온다.
    선택 인수는 첫 행의 번호이다. (디폴트 1)

공통 옵션으로 `:class:`_ 와 `:name:`_ 가 있다.

예시 ::
  아래 명령어의 내용 ::

    .. code:: python

      def my_function():
          "just a test"
          print 8/2

  파이선 소스 코드와 같이 파싱되고 마크업 된다.


수학
======

:명령어 타입: "math"
:Doctree 요소: math_block_
:명령어 인수: 1개, 선택: 내용의 접두어가 된다.
:명령어 옵션: `:class:`_, `:name:`_
:명령어 인수: 수학 블럭의 본문이 된다.
                    (공백행으로 구분된 내용 블럭은
                    인접한 수학 블럭에 놓인다.)
:배열 설정: math_output_

(Docutils 0.8에 신규 등록)

"math" 명령어는 문서에 수학적 내용(수식, 방정식)이 담긴 블럭을 삽입한다.
입력 포맷은 유니코드 기호를 지원하는 *LaTeX math syntax*\ [#math-syntax]_ 이다.
예시 ::

  .. math::

    α_t(i) = P(O_1, O_2, … O_t, q_t = S_i λ)

다수의 출력 포맷을 위해 요구되는 변환에 의해 *LaTex math* 의 일부분만 지원된다.
HTMl에서 `math_output`_ 배열 설정은 각각의 지원 요소들의 하위 집합과 함께 대체 출력 포맷들 중에서 결정된다.
(`math_output`_ 배열 설정은 ``--math-output`` 커맨드 라인 옵션에 대응하기도 한다.)
작성기가 수학 식자를 전혀 지원하지 않는다면 작성된 내용 그대로 삽입된다.

.. [#math-syntax] 지원되는 LaTeX 커맨드는 AMS 확장을 포함한다.
   (`Short Math Guide`_ 와 같은 문서를 참고하라.)


인라인 수식을 위해 `"수학" 기능`_ 을 사용한다.

.. _Short Math Guide: ftp://ftp.ams.org/ams/doc/amsmath/short-math-guide.pdf
.. _"수학" 기능: roles_ko.html#math
.. _math_output: ../../user/config.html#math-output

지시문
========

:명령어 타입: "rubric"
:Doctree 요소: rubric_
:명령어 인수: 1, 필수 (지시문 텍스트).
:명령어 옵션: `:class:`_, `:name:`_
:명령어 내용: None.

..

     rubric n. 1. a title, heading, or the like, in a manuscript,
     book, statute, etc., written or printed in red or otherwise
     distinguished from the rest of the text. ...

     -- 랜덤 하우스 웹스터 대학 사전, 1991

"rubric" 명령어는 지시문 요소를 문서 계층에 삽입한다.
지시문은 형식에 얽매이지 않는 제목으로 문서의 구조와 일치하지 않아도 된다.

제명
========

:명령어 타입: "epigraph"
:Doctree 요소: block_quote_
:명령어 인수: None.
:명령어 옵션: None.
:명령어 내용: 블럭 인용의 본문으로 해석됨.

제명은 문서나 섹션의 시작에 오는 적절하고 짧은 글로 주로 인용이나 시가 쓰인다.

"epigraph" 명령어는 "epigraph" 클래스 블럭 인용을 만들어 낸다. 예시 ::

     .. epigraph::

        네가 어디로 가든, 그 곳에 네가 있다.

        -- 버카루 반자이

위 코드는 아래와 같은 계층 조각이 된다. ::

    <block_quote classes="epigraph">
        <paragraph>
            네가 어디로 가든, 그 곳에 네가 있다.
        <attribution>
            버카루 반자이


강조
==========

:명령어 타입: "highlights"
:Doctree 요소: block_quote_
:명령어 인수: None.
:명령어 옵션: None.
:명령어 내: 블럭 인용의 본문으로 해석됨.

강조는 문서나 섹션의 요점을 요약하고 주로 목록의 구성이 된다.

"highlights" 명령어는 "highlights" 클래스 블럭 인용을 만들어 낸다.
`제명`_ 에서 유사한 예시를 볼 수 있다.

풀 인용
==========

:명령어 타입: "pull-quote"
:Doctree 요소: block_quote_
:명령어 인수: None.
:명령어 옵션: None.
:명령어 내용: 블럭 인용의 본문으로 해석됨.

풀 인용은 추출 인용된 텍스트의 작은 섹션으로 주로 큰 서체가 사용된다.
풀 인용은 독자의 주의를 끌고자 할 때 사용되며 특히 긴 글에 쓰인다.

"pull-quote" 명령어는 "pull-quote" 클래스 블럭 인용을 만들어 낸다.
`제명`_ 에서 유사한 예시를 볼 수 있다.

복합 문단
==================

:명령어 타입: "compound"
:Doctree 요소: compound_
:명령어 인수: None.
:명령어 옵션: `:class:`_, `:name:`_
:명령어 내용: 구성요소로 해석됨.

(Docutils 0.3.6에 신규 등록)

"compound" 명령어는 복합 문단을 만드는데 사용된다.
복합 문단은 논리적으로는 하나인 문단에 여러개의 물리적인 구성요소가 포함되는 경우를 말한다.
(단순히 텍스트나 인라인 요소들만 포함하는 대신)
복합 문단을 구성하는 요소로는 단순 문단, 리터럴 블럭, 표, 리스트 등이 있다. 예시 ::

    .. compound::

       'rm' 커맨드는 매우 위험하다.  만약 당신이 루트로 들어가
       엔터를 치게 되면 ::

           cd /
           rm -rf *

       파일 시스템의 모든 내용을 지우게 된다.

위의 예시에서 리터럴 블럭은 하나의 물리적 문단에서 시작해 다른 곳에서 끝나는 문장 내부에 삽입된다.

.. note::

   "compound" 명령어는 HTML의 ``<div>`` 요소 같은 포괄 블럭 계층 컨테이너가 아니다.
   단순히 연속되는 요소들을 묶기 위해 사용한다면 예상치 못한 결과를 얻을 수 있다.

   만약 포괄 계층 블럭 컨테이너가 필요하다면 밑에서 다룰 `컨테이너`_ 명령어를 사용하라.

복합 문단은 일반적으로 구별할 수 있는 여러개의 텍스트 블럭으로 구현되며
여러 텍스트 블럭들의 논리 통일성을 강조할 수 있게 변형될 가능성이 있다.:

* 만약 문단이 시작 줄 들여쓰기와 함께 구현된다면
  복합 문단의 첫번째 물리적 문단만이 동일한 들여쓰기를 가져야 한다.
  두번째와 그 이후에 오는 문단들은 들여쓰기를 생략해야 한다.
* 물리적 요소들 간의 수직방향 간격은 축소될 수 있다.;
* 기타 등등


컨테이너
=========

:명령어 타입: "container"
:Doctree 요소: container_
:명령어 인수: 1개 혹은 그 이상, 선택 (클래스명).
:명령어 옵션: `:name:`_
:명령어 내용: 구성요소로 해석됨.

(Docutils 0.3.10에 신규 등록)

"container" 명령어는 포괄 블럭 계층 컨테이너 요소와 함께 컨테이너의 내용(임의의 구성요소)를 둘러싼다.
선택적 "class_" 객체 인수와 결합되면 사용자와 어플리케이션을 위한 확장 메커니즘이 된다. 예시 ::

    .. container:: custom

       이 문단은 사용지 지정 방법으로 구현된다.

위의 결과를 pseudo-XML로 나타내면 아래와 같다. ::

    <container classes="custom">
        <paragraph>
            이 문단은 사용자 지정 방법으로 구현된다.

"container" 명령어는 HTML의 ``<div>`` 요소와 동일하다.
사용자나 어플리케이션의 목적에 맞게 연속적인 요소들을 그룹으로 묶는데 사용된다.



----------------
 테이블(Tables)
------------------

형식이 있는 테이블은 reStructuredText 문법이 제공하는 것보다 많은 구조를 필요로 한다.
테이블은 `테이블`_ 명령어를 통해 표제를 받을 수 있다.
종종 reStructuredText의 테이블은 작성하기 불편하지만 표준 포맷의 테이블 데이터는 손쉽게 얻을 수 있다.
csv-table_ 명령어는 CSV 포맷 데이터를 지원한다.


테이블
=====

:명령어 타입: "table"
:Doctree 요소: table_
:명령어 인수: 1개, 선택 (테이블의 표제).
:명령어 옵션: 가능 (아래 참조).
:명령어 내용: 일반 reStructuredText 테이블.

(Docutils 0.3.1에서 신규 등록)

"table" 명령어는 테이블이나 특정 옵션을 제목과 결합하는데 사용된다. 예시 ::

    .. table:: "not" 을 위한 진리표
       :widths: auto

       =====  =====
         A    not A
       =====  =====
       False  True
       True   False
       =====  =====

아래의 옵션들이 인식된다.:

``align`` : "left", "center", or "right"
    테이블의 수평방향 정렬
    (Docutils 0.13에서 신규 등록)

``widths`` : "auto", "grid" 또는 정수 목록
    콤마나 공백으로 구분되는 컬럼 너비 목록.
    디폴트는 입력 열의 너비. (문자로)

    "auto"나 "grid"는 작성자가 컬럼 너비 결정의 백엔드 위임 여부를 정할 때 사용한다.
    (LaTeX, the HTML browser, ...).
    `table_style`_ 배열 옵션을 참고하라.

공통 옵션으로 `:class:`_ 와 `:name:`_ 가 있다.

.. _table_style: ../../user/config.html#table-style-html4css1-writer

.. _csv-table:

CSV 테이블
=========

:명령어 타입: "csv-table"
:Doctree 요소: table_
:명령어 인수: 1, 선택 (테이블의 표제).
:명령어 옵션: 가능 (아래 참조).
:명령어 내용: A CSV (comma-separated values) table.

.. WARNING::

   "csv-table" 명령어의 ":file:" 과 ":url:" 옵션은 보안상 취약점이 될 수 있다.
   이 두 옵션은 "file_insertion_enabled_" 런타임 설정으로 비활성화 할 수 있다.

(Docutils 0.3.4에서 신규 등록)

"csv_table" 명령어는 CSV 데이터로부터 테이블을 만들 때 사용된다.
CSV는 상업용 데이터베이스와 스프레드시트 어플리케이션을 통해 생성되는 일반적인 데이터 포맷이다.
데이터는 문서의 일부가 되는 내부 자료이거나 분리된 파일에서 가져오는 외부 자료 모두 가능하다.

예시 ::

    .. csv-table:: Frozen Delights!
       :header: "Treat", "Quantity", "Description"
       :widths: 15, 10, 30

       "Albatross", 2.99, "On a stick!"
       "Crunchy Frog", 1.49, "If we took the bones out, it wouldn't be
       crunchy, now would it?"
       "Gannet Ripple", 1.99, "On a stick!"

셀 내부에서 블럭 마크업과 인라인 마크업이 지원된다. 행의 끝은 셀 내부에서 인식된다.

작업 한계:

* 각각의 행이 동일한 갯수의 컬럼을 갖는지는 확인해주지 않지만
  "csv-table" 명령어는 자동으로 항목을 비워두는 CSV 생성기를 지원하기 때문에
  짧은 행의 끝이 비워지는 일은 일어나지 않는다.

  .. 입력을 확인하기 위해 엄격한 옵션을 추가하고 싶다면?

.. [#whitespace-delim] 공백 구분 기호는 외부 CSV 파일에서만 지원된다.

.. [#ASCII-char] 파이썬2에서 ``delimiter``, ``quote``, ``escape`` 옵션은 ASCII 문자여야 한다.
   (CSV 모듈은 유니코드나 ASCII가 아닌 모든 문자들을 지원하지 않는다.
   이 한계점은 파이썬3에서는 나타나지 않는다.

아래의 옵션들이 인식된다.

``widths`` : 정수 [, 정수...] 또는 "auto"
    콤마 혹은 공백으로 구분되는 리스트의 상대적인 컬럼 너비이다.
    디폴트에서는 컬럼들이 동일한 너비를 갖는다. (100%/#columns)

    "auto" 값은 작성자가 열 너비 결정의 백엔드 위임 여부를 정할 때 사용한다.
    (LaTeX, the HTML browser, ...).

``header-rows`` : 정수
    테이블 헤더에서 사용할 CSV 데이터의 열 갯수. 디폴트 0.

``stub-columns`` : 정수
    stub으로 사용될 테이블의 컬럼 갯수. (좌측에서의 열의 이름) 디폴트 0.

``header`` : CSV 데이터
    테이블 헤더를 위한 추가 자료.
    테이블의 메인 CSV 데이터에서 얻은 ``header-rows`` 앞에 별개로 추가된다.
    메인 CSV 데이터와 동일한 포맷의 CSV를 사용해야 한다.

``file`` : 문자열 (새 라인 제거됨.)
    CSV 파일의 로컬 주소.

``url`` : 문자열 (공백 제거됨.)
    CSV 파일의 인터넷 URL 레퍼런스.

``encoding`` : 텍스트의 인코딩명
    외부 CSV 데이터(파일 혹은 URL)의 텍스트 인코딩.
    디폴트는 문서의 인코딩.

``delim`` : 문자 | "tab" | "space" [#whitespace-delim]_
    필드를 나누기 위해 사용되는 단일문자\ [#ASCII-char]_ .
    디폴트는 ``,`` (콤마).
    유니코드 포인트로 명시될 수 있다.; 문법적인 세부사항은 `유니코드`_ 명령어 참조.

``quote`` : 문자
    구분 기호를 포함하는 요소를 인용하거나 인용 문자와 함게 시작하는 단일문자\ [#ASCII-char]_
    디폴트는 ``"`` (따옴표).
    유니코드 포인트로 명시될 수 있다.; 문법적인 세부사항은 `유니코드`_ 명령어 참조.

``keepspace`` : flag
    구분 기호 바로 뒤에 오는 공백을 중요하게 다룬다.
    디폴트는 공백을 무시한다.

``escape`` : 문자
    구분 기호나 인용 문자에서 벗어나기 위해 사용되는 단일문자\ [#ASCII-char]_
    유니코드 포인트로 명시될 수 있다.; 문법적인 세부사항은 `유니코드`_ 명령어 참조.
    구분 기호가 인용 필드가 아닌 곳에서 쓰이거나 인용 문자를 일반 필드에서 입력하고자 할 때 사용된다.
    디폴트는 인용 문자를 두번 입력한다. 예시 "그는 말했다 ""안녕"""

    .. 디폴트를 명확하게 지정하기 위해 추가할 수 있는 값 "double" ?

``align`` : "left", "center" 또는 "right"
    테이블의 수평방향 정렬.
    (Docutils 0.13에서 신규 등록)

공통 옵션으로 `:class:`_ 와 `:name:`_ 가 있다.


리스트 테이블
============

:명령어 타입: "list-table"
:Doctree 요소: table_
:명령어 인수: 1개, 선택 (테이블 표제).
:명령어 옵션: 가능 (아래 참조).
:명령어 내용: 균일한 2개의 계층을 갖는 글머리 기호 리스트.

(Docutils 0.3.8.에서 신규 등록.  이것이 기존의 구현이지만 장래에 `추가적인 구상`__ 이 구현될 수 있다.)

__ ../../dev/rst/alternatives.html#list-driven-tables

"list_table" 명령어는 2개의 균일 계층 글머리 기호 리스트인 데이터로부터 테이블을 만든다.
균일 계층이란 하위 리스트들이 동일한 갯수의 항목을 포함함을 의미한다

예시 ::

    .. list-table:: Frozen Delights!
       :widths: 15 10 30
       :header-rows: 1

       * - Treat
         - Quantity
         - Description
       * - Albatross
         - 2.99
         - On a stick!
       * - Crunchy Frog
         - 1.49
         - If we took the bones out, it wouldn't be
           crunchy, now would it?
       * - Gannet Ripple
         - 1.99
         - On a stick!

아래의 옵션들이 인식된다.
``widths`` : 정수, [정수...] 또는 "auto"
    콤마 혹은 공백으로 구분되는 리스트의 상대적인 컬럼 너비이다.
    디폴트에서는 컬럼들이 동일한 너비를 갖는다. (100%/#columns)

    "auto" 값은 작성자가 열 너비 결정의 백엔드 위임 여부를 정할 때 사용한다.
    (LaTeX, the HTML browser, ...).

``header-rows`` : 정수
    테이블 헤더에서 사용할 CSV 데이터의 열 갯수. 디폴트 0.

``stub-columns`` : 정수
    stub으로 사용될 테이블의 컬럼 갯수. (좌측에서의 열의 이름) 디폴트 0.

``align`` : "left", "center" 또는 "right"
    테이블의 수평방향 정렬.
    (Docutils 0.13에서 신규 등록)

공통 옵션으로 `:class:`_ 와 `:name:`_ 가 있다.


----------------
 문서 파트
----------------

.. _contents:

목차 테이블
=================

:명령어 타입: "contents"
:Doctree 요소: pending_, topic_
:명령어 인수: 1개, 선택 (제목)
:명령어 옵션: 가능
:명령어 내용: None.

"contents" 명령어는 `토픽`_ 에 목차 테이블(TOC)를 생성한다.
토픽과 마찬가지로 목차표는 섹션과 전이가 나타날 수 있는 곳이면 어디든 올 수 있다.
구성요소와 토픽은 목차표를 포함하지 않을 수 있다.

명령어의 가장 간단한 형태 ::

    .. contents::

언어 의존 상용구 텍스트가 표제로 사용된다. 영어에서 디폴트 표제 텍스트는 "Contents" 이다.

구체적인 표제가 명시될 수 있다. ::

    .. contents:: 목차 테이블

표제는 여러줄이 될 수 있지만 권장하지 않는다. ::

    .. contents:: 이것은 아주 긴
       목차 테이블의 예시이다.

명령어를 위한 옵션들은 필드 리스트를 사용해 명시된다. ::

    .. contents:: 목차 테이블
       :depth: 2

만약 디폴트 표제가 사용된다면 옵션 필드 리스트는 명령어 마커와 동일한 라인에서 시작될 수 있다. ::

    .. contents:: :depth: 2

아래의 옵션들이 인식된다.

``depth`` : 정수
    목차 테이블에서 수집될 섹션 계층의 갯수.
    디폴트에서는 무한정 가능하다.

``local`` : flag (공란)
    로컬 목차 테이블을 생성한다. 입력란은 명령어가 주어지는 섹션의 하위 섹션만을 포함한다.
    구체적인 표제가 주어지지 않는다면 목차 테이블은 표제되지 않는다.

``backlinks`` : "entry" 또는 "top" 또는 "none"
    섹션 헤더로부터 목차 테이블 혹은 그 입력란으로 돌아가는 링크를 생성한다.
    백링크를 생성하지 않을 수도 있다.

``class`` : 텍스트
    토픽 요소상에 `"classes"`_ 객체값을 설정한다.
    아래의 `클래스`_ 명령어를 보자.

.. _sectnum:
.. _section-numbering:

자동 섹션 번호 지정
===========================

:명령어 타입: "sectnum" 또는 "section-numbering" (동의어)
:Doctree 요소: pending_, generated_
:명령어 인수: None.
:명령어 옵션: 가능.
:명령어 내용: None.
:배열 설정: sectnum_xform_

"sectnum" (또는 "section-nubmering") 명령어는 문서의 섹션과 하위 섹션에 자동으로 번호를 부여한다.
(`sectnum_xform`_ 배열 설정 혹은 ``--no-section-numbering`` 커맨드 라인으로 비활성화 되지 않은 경우)

섹션 번호는 "multiple enumeration" 형태로 각각의 계층이 번호를 갖고 구두점으로 구분된다.
예를 들어, 섹션 1, 하위 섹션 2, 하위 섹션 3의 표제는 "1.2.3" 으로 부가된다.

"sectnum" 명령어는 초기 파싱과 변형 두가지 단계로 기능한다.
초기 파싱에서 "pending" 요소가 생성되어 자리 표시자로 기능하고 어떤 옵션이든 내부에 저장한다.
프로세싱의 나중 단계에서 "pending" 요소는 표제에 섹션 번호를 붙이는 변형을 일으킨다.
섹션 번호는 "generated" 요소에 묶이고 표제는 1로 설정되는 "auto" 객체를 갖는다.

아래의 옵션들이 인식된다.:

``depth`` : 정수
    명령어에 의해 번호가 부여될 섹션의 갯수.
    디폴트에서는 무한정 가능하다.

``prefix`` : 문자열
    자동으로 생성된 섹션 번호에 부가될 임의의 문자열.
    "3.2." 이 입력되면 섹션 번호는 "3.2.1", "3.2.2", "3.2.2.1" 과 같이 생성된다.
    구분 구두점("." 과 같은 것들)은 명백하게 정해져야 한다.
    디폴트에서는 아무것도 부가되지 않는다.

``suffix`` : 문자
    자동으로 생성된 섹션 번호 뒤에 덧붙일 임의의 문자열.
    디폴트는 아무것도 부가되지 않는다.

``start`` : 정수
    첫번째 섹션 번호가 될 값.
    ``prefix`` 와 결합되어 여러개의 소스 파일로 나누어질 문서에 올바른 섹션 번호를 부여하기 위해 사용된다.
    디폴트는 1 이다.

.. _sectnum_xform: ../../user/config.html#sectnum-xform


.. _header:
.. _footer:

문서 헤더와 푸터
========================

:명령어 타입: "header" 또는 "footer"
:Doctree 요소: decoration_, header, footer
:명령어 인수: None.
:명령어 옵션: None.
:명령어 내용: 구성요소로 해석됨.

(Docutils 0.3.8에서 신규 등록)

"header" 와 "footer" 명령어는 페이지 네비게이션, 노트, 시간/날짜 등에 유용한 문서 장식을 생성한다. 예시 ::

    .. header:: 이 공간은 임대용.

인쇄될 페이지나 생성될 웹페이지 상단에 나타날 문서 헤더에 문단을 추가한다.

이 명령어들은 여러번 누적하여 사용될 수 있다. 최근에는 단 하나의 헤더와 푸터도 지원한다.

.. note::

   "header", "footer" 명령어를 웹페이지의 네비게이션 요소를 생성하는데 사용할 수는 있지만
   Docutils는 본래 *문서* 프로세싱을 위해 사용된다는 것과
   네비게이션바는 일반적으로 문서의 일부가 아님을 인지해야 한다.

   Docutils 의 기능은 그러한 목적에 사용하기엔 불충분하다는 것을 곧 깨달을 것이다.
   그 때는 "header", "footer" 명령어 대신 Sphinx_ 와 같은 문서 생성기를 사용하는 것을 고려해야 한다.

   .. _Sphinx: http://sphinx-doc.org/

헤더와 푸터 내용물을 위 명령어들로 채우는 것 외에도 내용물은 프로세싱 시스템에 의해 자동으로 추가될 수도 있다.
예를 들어, 특정 런타임 설정이 가능하다면 문서 푸터는 날짜나 `Docutils 웹사이트`_ 같은 프로세싱 정보로 채워진다.

.. _Docutils 웹사이트: http://docutils.sourceforge.net


------------
 레퍼런스
------------

.. _target-notes:

대상 각주
================

:명령어 타입: "target-notes"
:Doctree 요소: pending_, footnote_, footnote_reference_
:명령어 인수: None.
:명령어 옵션: `:class:`_, `:name:`_
:명령어 옵션: 가능.
:명령어 내용: None.

"target-notes" 명령어는 텍스트에 각각의 외부 대상을 위한 각주를 만든다.
이 각주들은 각각의 레퍼런스로 부터 온 각주 레퍼런스에 대응한다.
텍스트의 모든 명시적인 대상에 맞춰 생성된 각주는 가시적인 URL을 내용으로 포함한다.


각주
=========

**아직 구현되지 않음.**

:명령어 타입: "footnotes"
:Doctree 요소: pending_, topic_
:명령어 인수: None?
:명령어 옵션: 가능?
:명령어 내용: None.

@@@


Citations
=========

**아직 구현되지 않음.**

:Directive Type: "citations"
:Doctree 요소: pending_, topic_
:명령어 인수: None?
:명령어 옵션: 가능?
:명령어 내용: None.

@@@


---------------
 HTML-Specific
---------------

메타
======

:명령어 타입: "meta"
:Doctree 요소: meta (비표준)
:명령어 인수: None.
:명령어 옵션: None.
:명령어 내용: 반드시 단순 필드 리스트를 포함해야 함.

"meta" 명령어는 HTML 메타 태그에 저장된 메타데이터를 명시할 때 사용한다.
"Metadata"는 데이터에 대한 데이터로 이 경우엔 웹페이지에 대한 데이터에 해당한다.
메타데이터는 월드 와이드 웹에서 검색 엔진이 추출하고 수집하기 좋은 형태로 웹페이지를 서술하고 분류하는데 쓰인다.

명령어 블럭 내부에서 단순 필드 리스트는 메타데이터를 위한 문법을 제공한다.
필드명은 메타 태그 "name" 객체의 내용이 되고 필드 본문(인라인 마크업 없는 단일 문자열로 해석됨)은 "content" 객체의 내용이 된다.
예시 ::

    .. meta::
       :description: reStructuredText 일반 텍스트 마크업 언어
       :keywords: 일반 텍스트, 마크업 언어

아래의 HTML로 변환된다. ::

    <meta name="description"
        content="reStructuredText 일반 텍스트 마크업 언어">
    <meta name="keywords" content="일반 텍스트, 마크업 언어">

다른 메타 객체들("http-equiv", "scheme", "lang", "dir")의 지원은 필드 인수를 통해 제공되며
반드시 "attr=value"의 형태가 되어야 한다. ::

    .. meta::
       :description lang=en: An amusing story
       :description lang=fr: Une histoire amusante

HTML에서는 ::

    <meta name="description" lang="en" content="An amusing story">
    <meta name="description" lang="fr" content="Une histoire amusante">

몇몇 메타 태그는 "name" 객체 대신 "http-equiv" 를 사용한다.
"http-equiv" 메타 태그를 명시하려면 이름을 생략한다. ::

    .. meta::
       :http-equiv=Content-Type: text/html; charset=ISO-8859-1

HTML에서는 ::

    <meta http-equiv="Content-Type"
         content="text/html; charset=ISO-8859-1">



이미지맵
========

**아직 구현되지 않음.**

비표준 요소: 이미지맵.


-----------------------------------------
 대체 정의를 위한 명령어
-----------------------------------------

이번 섹션의 명령어들은 대체 정의에서만 쓰일 수 있다.
이 명령어들은 독자적인 문맥에서 직접적으로 사용되지 않을 수 있으며
`image`_ 명령어는 대체 정의, 독자적인 문맥에서 모두 사용될 수 있다.

.. _replace:

대체 텍스트
================

:명령어 타입: "replace"
:Doctree 요소: 텍스트 & `inline elements`_
:명령어 인수: None.
:명령어 옵션: None.
:명령어 내용: 단일 문단; 인라인 마크업을 포함할 수 있음.

"replace" 명령어는 대체 레퍼런스를 위한 대체 텍스트를 나타내는데 쓰인다.
대체 정의 내부에서만 쓰일 수도 있다. 예를 들어 이 명령어는 축약형을 확장하는데 쓰인다. ::

    .. |reST| replace:: reStructuredText

    |reST|는 긴 단어이기 때문에,
    누군가 이를 축약하고 싶다고 해도 비난할 수 없다.

reStructuredText는 내포된 인라인 마크업을 지원하지 않기 때문에
레퍼런스를 양식이 있는 텍스트로 생성하려면 "replace" 명령어를 사용해 대체하는 수 밖에 없다. ::

    |Python|_ 을 시도해 보는 것을 추천한다.

    .. |Python| replace:: Python, *최고*의 언어
    .. _Python: http://www.python.org/


.. _유니코드:

유니코드 문자 코드
=======================

:명령어 타입: "unicode"
:Doctree 요소: 텍스트
:명령어 인수: 1개 이상, 필수 (유니코드 문자 코드), 선택 (텍스트와 코멘트).
:명령어 옵션: 가능.
:명령어 내용: None.

"unicode" 명령어는 유니코드 문자 코드(숫자값)을 변환하며 대체 정의에서만 사용된다.

공백으로 구별되는 인수:

* **문자 코드**

  - 십진법수

  - 십육진법수,
    ``0x``, ``x``, ``\x``, ``U+``, ``u``, ``\u`` 또는 XML 스타일 십육진법 문자 요소가 붙는다.
    예시 ``&#x1a2b;``

* **텍스트**, 그대로 쓰인다.

" .. " 뒤에 오는 텍스트는 코멘트이며 무시된다. 인수 사이의 공간은 무시되며 출력시 나타나지 않는다.
십육진법 코드는 대소문자를 구분하지 않는다.

예를 들어 아래의 텍스트는::

    Copyright |copy| 2003, |BogusMegaCorp (TM)| |---|
    all rights reserved.

    .. |copy| unicode:: 0xA9 .. copyright sign
    .. |BogusMegaCorp (TM)| unicode:: BogusMegaCorp U+2122
       .. with trademark sign
    .. |---| unicode:: U+02014 .. em dash
       :trim:

아래와 같은 결과가 된다.:

    Copyright |copy| 2003, |BogusMegaCorp (TM)| |---|
    all rights reserved.

    .. |copy| unicode:: 0xA9 .. copyright sign
    .. |BogusMegaCorp (TM)| unicode:: BogusMegaCorp U+2122
       .. with trademark sign
    .. |---| unicode:: U+02014 .. em dash
       :trim:

아래의 옵션들이 인식된다.

``ltrim`` : flag
    대체 레퍼런스의 좌측 공백이 제거된다.

``rtrim`` : flag
    대체 레퍼런스의 우측 공백이 제거된다.

``trim`` : flag
    ``ltrim`` 과 ``rtrim`` 모두 적용되는 것과 동일.

날짜
======

:명령어 타입: "date"
:Doctree 요소: 텍스트
:명령어 인수: 1개, 선택 (날짜 형식).
:명령어 옵션: None.
:명령어 내용: None.

"date" 명령어는 현재 로컬 시간을 생성하고 텍스트로 문서에 삽입한다. 이 명령어는 대체 정의에서만 사용될 수 있다.

선택적 명령어 내용은 권장되는 날짜 형식으로 해석되며 파이썬 코드의 time.strftime 함수와 동일하게 사용된다.
디폴트 형식은 "%Y-%m-%d" (ISO 8601 date)이지만 시간 필드도 사용될 수 있다. 예시 ::

    .. |date| date::
    .. |time| date:: %H:%M

    오늘의 날짜는 |date|.

    이 문서는 |date| / |time| 에 생성됨.


---------------
기타
---------------

.. _include:

외부 문서 조각 포함하기
=======================================

:명령어 타입: "include"
:Doctree 요소: 포함될 데이터에 의존. (``code``를 포함하는 `리터럴 블럭`_ 또는 ``literal`` 옵션)
:명령어 인수: 1개, 필수 (포함할 파일의 경로).
:명령어 옵션: 가능.
:명령어 내용: None.
:배열 설정: file_insertion_enabled_

.. WARNING::

   "include" 명령어는 보안상 취약점이 될 수 있다.
   "file_insertion_enabled_" 런타임 설정으로 비활성화 할 수 있다.

   .. _file_insertion_enabled: ../../user/config.html#file-insertion-enabled

"include" 명령어는 텍스트 파일을 읽는다.
명령어 인수는 포함할 파일의 경로이며 명령어를 포함하는 문서를 기준으로 한다.
``literal``, ``code`` 옵션이 주어지지 않는 한, 포함될 파일은 현재 문서의 맥락에서 명령어의 관점으로 파싱된다.
예시 ::

    첫번째 예시는 문서 계층에서 파싱되고 섹션 헤더를 포함한 어떤 구조든 포함할 수 있다.

    .. include:: inclusion.txt

    본래의 문서로 돌아오자.

        두번째 예시는 블럭 인용의 맥락에서 파싱된다.
        그러므로 구성요소만 포함할 수 있고 섹션 헤더를 포함하지 않을 수 있다.

        .. include:: inclusion.txt

포함된 문서 조각이 섹션 구조를 포함한다면 표제 장식은 마스터 문서의 것을 따라야 한다.

reStructuredText 문서의 포함되도록 지정된 표준 데이터 파일은 Docutils 소스코드와 함께 배포되며
``docutils/parsers/rst/include`` 디렉토리 내부의 "docutils" 패키지에 위치한다.
이 파일들에 접근하려면 표준 "include" 데이터 파일을 위한 문법을 사용한다.
꺽쇠 괄호로 파일명을 둘러싼다. ::

    .. include:: <isonum.txt>

현재 표준 "include" 데이터 파일 집합은 대체 정의들의 집합으로 구성된다.
`reStructuredText 표준 정의 파일`__ 에서 세부사항을 볼 수 있다.

__ definitions_ko.html

아래의 옵션들이 인식된다. :

``start-line`` : 정수
    지정된 라인에서 시작되는 내용만이 포함된다.
    (일반적인 파이썬에서 첫째줄은 인덱스 0, 음수값들은 끝에서부터 센다)

``end-line`` : 정수
    지정된 라인을 제외하고 그 이전 내용만이 포함된다.

``start-after`` : 외부 데이터 파일에서 찾을 텍스트
    지정된 텍스트가 처음 나타난 이후의 내용들만 포함된다.

``end-before`` : 외부 데이터 파일에서 찾을 텍스트
    지정된 텍스트가 처음 나타난 이전의 내용들만 포함된다.

``literal`` : flag (공란)
    문서에 삽입될 모든 텍스트가 하나의 리터럴 블럭으로 삽입된다.

``code`` : 형식 언어 (선택)
    포함될 파일의 인수와 내용이 `코드`_ 명령어를 지난다. (프로그램 리스트에 유용)
    (Docutils 0.9에서 신규 등록)

``number-lines`` : [시작줄 번호]
    줄번호와 함께 모든 코드 라인에 선행한다.
    선택 인수는 시작줄의 번호이다. (디폴트 1)
    ``code``, ``literal``과 함께 있을 때만 작동한다.
    (Docutils 0.9에서 신규 등록)

``encoding`` : 텍스트 인코딩명
    외부 데이터 파일의 텍스트 인코딩.
    디폴트는 문서의 input_encoding_ 이 된다.

    .. _input_encoding: ../../user/config.html#input-encoding

``tab-width`` :  정수
    하드 탭 확장을 위한 간격의 갯수. 음수값은 하드탭의 확장을 방지한다.
    디폴트는 tab_width_ 배열 설정이다.

    .. _tab_width: ../../user/config.html#tab-width

``code`` 또는 ``literal`` 과 공통 옵션 `:class:`_, `:name:`_ 이 인식된다.

``start/end-line`` 과 ``start-after/end-before`` 을 결합할 수 있다.
포함할 내용을 제한할 텍스트 마커는 지정한 라인에서 검색된다.

.. _raw-directive:

미가공 데이터 경유
=====================

:명령어 타입: "raw"
:Doctree 요소t: raw_
:명령어 인수: 1개 이상, 필수 (출력 포맷 타입).
:명령어 옵션: 가능.
:명령어 내용: 해석되지 않고 그대로 저장됨. "file" 혹은 "url" 옵션이 주어진 경우 None.
:배열 설정: raw_enabled_

.. WARNING::

   "raw" 명령어는 보안상 취약점이 될 수 있다.
   "raw_enabled_" 또는 "file_insertion_enabled_" 런타임 설정으로 비활성화 할 수 있다.

   .. _raw_enabled: ../../user/config.html#raw-enabled

.. Caution::

   "raw" 명령어는 저자가 reStructuredText의 마크업으로 우회할 수 있게 하는 임시 방편으로
   오남용 되어선 안되는 파워 유저를 위한 기능이다.
   "raw" 명령어의 사용은 문서를 특정 출력 포맷으로 묶어 휴대성이 떨어지게 한다.

   "raw" 명령어나 이로부터 파생된 해석 텍스트 기능을 자주 사용해야 한다면
   오남용의 신호이거나 reStructuredText 의 사용 목적에서 벗어난 것일 수 있다.
   그럴 경우 당신의 상황을 Docutils-users_ 메일 리스트로 보내길 바란다.

.. _Docutils-users: ../../user/mailing-lists.html#docutils-users

"raw" 명령어는 작성기를 건드려지지 않고 통과할 non-reStructuredText 데이터를 지정한다.
출력 포맷의 명칭은 명령어 인수를 통해 주어진다. 미가공 데이터의 해석은 작성기에 달려있다.
미가공 출력이 주어진 포맷과 맞지 않을 경우 작성기는 이를 무시할 수 있다.

예를 들어, 아래의 입력은 HTML 작성기를 건드려지지 않은 채로 통과한다. ::

    .. raw:: html

       <hr width=50 size=10>

LaTeX 작성기는 아래의 미가공 내용물을 출력 스트림에 삽입할 수 있다. ::

    .. raw:: latex

       \setlength{\parindent}{0pt}

명령어 옵션에 지정하면 미가공 데이터를 외부 파일로부터 읽어올 수 있다.
이 경우 내용 블럭은 비게 된다. 예시 ::

    .. raw:: html
       :file: inclusion.html

`"raw" 기능`_ 에서 파생된 `사용자 지정 텍스트 기능`_ 을 통해 "raw" 명령어와 동등한 인라인 명령어가 정의될 수 있다.

아래의 옵션들이 인식된다.

``file`` : 문자열 (새 라인 제거됨)
    포함될 미가공 데이터의 로컬 파일시스템 경로.

``url`` : 문자열 (공백 제거됨)
    포함될 미가공 데이터의 인터넷 URL 레퍼런스.

``encoding`` : 텍스트 인코딩명
    외부 미가공 데이터(파일 혹은 URL)의 텍스트 인코딩.
    문서의 인코딩이 지정된 경우 디폴트값이 된다.

.. _"raw" 기능: roles_ko.html#raw


.. _classes:

클래스
========

:명령어 타입: "class"
:Doctree 요소: pending_
:명령어 인수: 1개 이상, 필수 (클래스명 / 객체값)
:명령어 옵션: None.
:명령어 내용: 선택. 내용이 있다면 구성요소로 해석됨.

"class" 명령어는 그 내용 또는 바로 뒤에 오는 [#]_ non-comment element [#]_ 에
`"classes"`_ 객체값을 설정한다.
"classes" 객체에 대한 세부사항은 `classes entry in The Docutils
Document Tree`__ 을 참고하라.

명령어 인수는 간격으로 구분되는 하나 이상의 클래스명으로 구성된다.
입력된 명칭들은 정규표현 ``[a-z](-?[a-z0-9]+)*`` 을 따르도록 변환된다.

* 소문자 알파벳
* 강조된 문자는 기초 문자로
* 영숫자가 아닌 문자는 하이픈으로
* 연이은 하이픈은 하나의 하이픈으로

예를 들어 "Rot-Gelb.Blau Grün:+2008" 는 "rot-gelb-blau grun-2008" 가 된다.
(`원리`_ 는 아래 참)

__ ../doctree.html#classes

예시 ::

    .. class:: special

    이것은 특별한 문단이다..

    .. class:: exceptional remarkable

    예외 섹션
    ======================

    일반적인 문단이다.

    .. class:: multiple

       첫번째 문단.

       두번째 문단.

위의 텍스트는 파싱과 변형을 통해 아래 doctree 조각이 된다. ::

    <paragraph classes="special">
        이것은 특별한 문단이다..
    <section classes="exceptional remarkable">
        <title>
            예외 섹션
        <paragraph>
            일반적인 문단이다.
        <paragraph classes="multiple">
            첫번째 문단.
        <paragraph classes="multiple">
            두번째 문단.


.. [#] 클래스 명령어가 들여쓴 텍스트 블럭 끝에 내포되어 있다면 이 또한 옳다. 예시 ::

       .. note:: 이 명령어 블럭에 설정된 클래스 값은 note 가 아닌
          다음 문단에 적용된다.

          .. class:: special

       "special" 클래스 값을 갖는 문단.

   이는 개별적인 리스트 항목의 분류를 가능하게 한다.
   (선행된 클래스 명령어가 리스트 전체에 적용되므로 첫번째 항목은 제외.) ::

       * 글머리 기호 리스트

         .. class:: classy item

       * 클래스 인수를 갖는 두번째 항목

.. [#] "classes" 객체를 블럭 인용에서 설정하려면
   "class" 명령어는 뒤에 반드시 빈 코멘트가 와야 한다. ::

       .. class:: highlights
       ..

           블럭 인용 텍스트.

   빈 코멘트가 없다면 들여쓴 텍스트는 "class" 명령어의 내용으로 해석되고
   클래스는 블럭 인용에 적용되는 대 각각의 요소들(위 경우엔 문단)에 개별적으로 적용될 것이다.

.. _`원리`:

.. topic:: "classes" 객체값 변환 원리


    Docutils 식별자는 정규표현 ``[a-z](-?[a-z0-9]+)*`` 을 따르도록 변환된다.
    HTML + CSS 호환성을 위해 식별자("classes", "id" 객체)는 밑줄, 콜론, 구두점이 없어야 한다.
    하이픈은 사용될 수 있다.

    - `HTML 4.01 사양`_ 은 SGML tokens에 기반해 식별자를 정의한다.:

          ID 와 NAME 토큰은 반드시 ([A-Za-z]) 문자로 시작해야하며
          이어서 문자, 숫자([0-9]), 하이픈("-"), 밑줄("_"), 콜론(":") 구두점(".")이
          얼마든지 올 수 있다.

    - `CSS1 사양`_ 은 "name" 토큰에 기반해 식별자를 정의한다.
      아래는 "flex" 토크나이저 표기법; "latin1" 과 "escape" 8-bit
      문자는 XML 요소로 대체)::

          unicode     \\[0-9a-f]{1,4}
          latin1      [&iexcl;-&yuml;]
          escape      {unicode}|\\[ -~&iexcl;-&yuml;]
          nmchar      [-A-Za-z0-9]|{latin1}|{escape}
          name        {nmchar}+

    The CSS 방식은 밑줄 ("_"), 콜론 (":"),구두점 (".")을 포함하지 않으므로
    "classes" 와 "id" 객체는 이 문자들을 포함해선 안된다.
    첫글자는 반드시 문자여야 한다는 HTML의 요구사항과 결합되어
    정규표현 ``[A-Za-z][-A-Za-z0-9]*`` 이 된다.
    Docutils 가 소문자화와 연이은 하이픈 결합을 표준화에 추가했다.

    .. _HTML 4.01 사양: http://www.w3.org/TR/html401/
    .. _CSS1 사양: http://www.w3.org/TR/REC-CSS1


.. _role:

사용자 지정 해석 텍스트 기능
=============================

:명령어 타입: "role"
:Doctree 요소: None; 이후의 파싱에 영향을 미침.
:명령어 인수: 2개; 필수 (신규 기능명), 선택(기존 기능명, 괄호 안에서)
:명령어 옵션: 가능 (기존 기능에 의존).
:명령어 내용: 기존 기능에 의존.

(Docutils 0.3.2에서 신규 등록)

"role" 명령어의 기능은 사용자 지정 해석 텍스트 기능을 동적으로 생성하고 파서에 이를 등록한다.
아래와 같이 기능을 선언한 후에 ::

    .. role:: custom

문서는 새로운 "custom" 기능을 사용할 수 있다. ::

    :custom:`interpreted text` 사용 예시

위 예시는 아래의 문서 계층 조각으로 파싱된다. ::

    <paragraph>
        사용 예시
        <inline classes="custom">
            interpreted text

사용자 지정 기능이 사용되기 전에 문서에서 선언되어야 한다.

새로운 기능은 기존 기능에 기반할 수 있고 괄호 안에 두번째 인수로 명시된다. (공백은 선택사항) ::

    .. role:: custom(emphasis)

    :custom:`text`

위 예시가 파싱된 결과 ::

    <paragraph>
        <emphasis classes="custom">
            text

`"raw" 기능`_ 은 특별한 경우이다.:
파생된 기능이 인라인 `미가공 데이터 경유`_ 를 가능하게 한다. 예시 ::

   .. role:: raw-role(raw)
      :format: html latex

   :raw-role:`raw text`

만약 기본 역할이 지정되지 않았다면 포괄 사용자 지정 기능이 자동으로 사용된다.
첫번째 예시와 같이 이후의 해석 텍스트는 `"classes"`_  객체와 함께 인라인 요소를 생성한다.

대부분의 기능과 함께 ":class:" 옵션은 기능명과 다른 "classes" 객체를 지정하는데 쓰일 수 있다.
예시 ::

    .. role:: custom
       :class: special

    :custom:`해석 텍스트`

아래는 파싱된 결과이다. ::

    <paragraph>
        <inline classes="special">
            해석 텍스트

.. _role class:

가장 기초적인 기능을 위해 "role" 명령어는 아래 옵션들을 인식한다.

``class`` : 텍스트
    사용자 지정 해석 텍스트 기능이 사용될 때 생성된 요소에 `"classes"`_ 객체값을 설정한다.
    (``inline`` 또는 기본 클래스와 관련된 요소)
    명령어 옵션이 지정되지 않은 경우 "class" 옵션과 값으로서의 명령어 인수(기능명)이 상정된다.
    `클래스`_ 명령어를 참고하라.

지정된 기존 기능은 다른 옵션이나 명령어 내용을 지원할 수 있다.
`reStructuredText 해석 텍스트 기능`_ 문서에서 세부사항을 볼 수 있다.

.. _reStructuredText 해석 텍스트 기능: roles_ko.html


.. _default-role:

디폴트 해석 텍스트 기능 설정
=========================================

:명령어 타입: "default-role"
:Doctree 요소: None; affects subsequent parsing.
:명령어 인수: 1개, 선택 (신규 디폴트 기능명).
:명령어 옵션: None.
:명령어 내용: None.

(Docutils 0.3.10에서 신규 등록)

"default-role" 명령어는 디폴트 해석 텍스트 기능을 설정한다.
설정된 기능은 명시된 기능이 없어도 해석 텍스트에 사용된다.
예를 들어 아래와 같이 디폴트 기능을 설정하면 ::

    .. default-role:: subscript

이후에 문서에서 기능이 내포된 해석 텍스트를 사용하면 앞서 설정한 "subscript" 기능을 사용하게 된다. ::

    An example of a `default` role.

이것은 아래 문서 계층 조각으로 파싱될 것이다. ::

    <paragraph>
        An example of a
        <subscript>
            default
         role.

사용자 지정 기능이 사용될 수 있지만 디폴트 기능으로 설정 가능하기 전에 문서에서 선언 되어 있어야 한다.
기본 제공 기능에 대해서는 `reStructuredText 해석 텍스트 기능`_ 문서를 참고하라.

이 명령어는 어플리케이션에 따라 기존의 디폴트 해석 텍스트 기능을 복원하는 인수 없이 사용될 수 있다.
표준 reStructuredText 파서에서 기존 디폴트 해석 텍스트 기능은 "title-reference" 이다.


메타데이터 문서 제목
=======================

:명령어 타입: "title"
:Doctree 요소: None.
:명령어 인수: 1개, 필수 (제목 텍스트).
:명령어 옵션: None.
:명령어 내용: None.

"title" 명령어는 문서의 제목을 메타데이터로 명시하고 문서 본문의 일부가 되진 않는다.
이 명령어는 문서가 제공하는 제목은 무시한다.
예를 들어 HTML 출력에서 메타데이터상의 문서 제목은 브라우저 창의 제목 바에 나타난다.


Restructuredtext 테스트 명령어
===============================

:명령어 타입: "restructuredtext-test-directive"
:Doctree 요소: system_warning
:명령어 인수: None.
:명령어 옵션: None.
:명령어 내: 리터럭 블럭으로 해석됨.

이 명령어는 테스트 용도로만 제공된다. 명령어 데이터를 나타내는 1레벨 시스템 메시지로 변환되고
이어서 나머지 명령어 블럭을 포함하는 리터럴 블럭이 올 수 있다.

--------------
공통 옵션
--------------

Doctree 요소를 생성하는 대부분의 명령어는 아래의 옵션들을 지원한다. :

_`:class:` : 텍스트
    명령어에 의해 생성되는 Doctree 요소 위에 `"classes"`_ 객체값을 설정한다.
    `클래스`_ 명령어를 참고하라.

_`:name:` : 텍스트
    명령어에 의해 생성되는 Doctree 요소의 `"names"`_ 객체에 텍스트를 추가한다.
    `참조명`_ 으로 텍스트를 사용해 `"names"`_ 객체가 `하이퍼링크 참조`_ 가 될 수 있게 한다.

    명령어의 `name` 옵션을 아래와 같이 명시할 수 있다. ::

      .. image:: bild.png
         :name: my picture

    위 예시는 `하이퍼링크 대상`_ 을 사용하는 방법을 대신하는 간편한 대안 문법이 된다. ::

      .. _my picture:

      .. image:: bild.png

    Docutils 0.8에서 신규 등록.


.. _참조명: restructuredtext.html#reference-nams
.. _하이퍼링크 대상: restructuredtext.html#hyperlink-targets
.. _하이퍼링크 참조:restructuredtext.html#hyperlink-references
.. _"classes": ../doctree.html#classes
.. _"names": ../doctree.html#names
.. _admonition: ../doctree.html#admonition
.. _block_quote: ../doctree.html#block-quote
.. _caption: ../doctree.html#caption
.. _compound: ../doctree.html#compound
.. _container: ../doctree.html#container
.. _decoration: ../doctree.html#decoration
.. _figure: ../doctree.html#figure
.. _footnote: ../doctree.html#footnote
.. _footnote_reference: ../doctree.html#footnote-reference
.. _generated: ../doctree.html#generated
.. _image: ../doctree.html#image
.. _inline elements: ../doctree.html#inline-elements
.. _literal_block: ../doctree.html#literal-block
.. _legend: ../doctree.html#legend
.. _line_block: ../doctree.html#line-block
.. _math_block: ../doctree.html#math-block
.. _pending: ../doctree.html#pending
.. _raw: ../doctree.html#raw
.. _rubric: ../doctree.html#rubric
.. _sidebar: ../doctree.html#sidebar
.. _table: ../doctree.html#table
.. _title: ../doctree.html#title
.. _topic: ../doctree.html#topic



..
   Local Variables:
   mode: indented-text
   indent-tabs-mode: nil
   sentence-end-double-space: t
   fill-column: 70
   End:
