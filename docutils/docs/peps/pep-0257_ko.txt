=================================
PEP 257 -- Docstring Conventions
=================================
:PEP: 257
:버전: $Revision$
:마지막-수정: $Date$
:저자: David Goodger <goodger@python.org>, Guido van Rossum <guido@python.org>
:토론-연락: doc-sig@python.org
:상태: Active
:유형: Informational
:정보-유형: text/x-rst
:생성날짜: 29-May-2001
:포스팅-날짜: 13-Jun-2001

.. contents::

개요
========

이 PEP는 Python docstring의 semantics와 규약에 대해 서술한다.


근거
===========

이 PEP의 목표는 docstring의 high-level 구조를 표준화하는 것이다. 이 PEP는 syntax가 아닌 규약만을 포함한다.

    

    

이 규약을 어기더라도 큰 문제는 되지 않지만, 일부 소프트웨어(Docutils_ docstring processing system [1]_ [2]_)는 규약을 알고 있기 때문에 가급적 지키는게 좋다.


상세
=============

Docstring이란 무엇인가?
------------------------------------

Docstring은 module, function, class, method 내에 첫 번째로 오는 string literal이다. 그러한 docstring은 그 객체의 ``__doc__`` 특수 속성이 된다.

모든 module, function, class는 일반적으로 docstring이 있어야 하며 public method(``__init__`` constructor 포함)에도 docstring은 있어야 한다. Package 또한 package directory에 있는 ``__init __.py`` 파일의 module docstring에 의해 documentation이 가능하다.

Python 코드 다른 곳에서의 string literal 또한 documentation으로 이용 될 수 있다. 이들은 Python bytecode compiler에 의해 인식되지 않고 runtime 객체 속성으로는 접근 할 수 없다 (즉 ``__doc__`` 에 할당되지 않는다). 하지만 소프트웨어 도구에 의해 두 종류의 docstring 추출이 가능하다.

1. Module, class, ``__init__`` method 선언 직후에 오는 string literal은 "속성(attribute) docstring"이라고 한다.

2. 다른 docstring 바로 뒤에 오는 string literal은 "추가(additional) docstring"이라고 한다.

속성 및 추가 docstring에 대한 자세한 설명은 PEP 258, "Docutils Design Specification"[2]_ 을 참조한다.



일관성을 위해 docstring은 항상 ``"""triple double quotes"""`` 를 사용한다. Docstring에서 backslash를 사용한다면 ``r"""raw triple double quotes"""`` 를 사용한다. Unicode docstring의 경우, ``u"""unicode triple-quoted string"""`` 을 사용한다.

Docstring에는 one-line과 multi-line으로 된 두 가지 형식이 있다.


One-line Docstring
--------------------

One-line docstring은 한줄에 전부 들어가야 한다. 예::

    def kos_root():
        """Return the pathname of the KOS root directory."""
        global _kos_root
        if _kos_root: return _kos_root
        ...

노트:

- 심지어 한줄 안에 다 들어가더라도 확장성을 생각하여 triple quote가 쓰인다.

- One-line docstring에서는 closing quote와 opening quote가 같은 줄에 있는게 보기 더 좋다.

- Docstring 앞뒤에 blank line이 없다.

- Docstring은 function이나 method의 기능을 설명하는 마침표로 끝나는 문장이다.

- One-line docstring은 function, method의 parameter를 알려주는 "서명"이 되어서는 안된다. 즉, 다음과 같이 하면 안된다::

      def function(a, b):
          """function(a, b) -> list"""

  이런 종류의 docstring은 introspection이 불가한 C function에나 적합하다. Introspection으로 *return value* 는 알 수 없으므로 언급하는게 좋다. 따라서 위 예시는 다음과 같이 쓰는게 좋다::

      def function(a, b):
          """Do X and return a list."""

  


Multi-line Docstring
----------------------

Multi-line docstring은 우선 요약줄이 오고, 그 다음 blank line이 오며, 그 이후 보다 자세한 설명이 이어진다. 요약줄은 automatic indexing tool에서 사용 가능하다. 요약줄은 한줄 안에 들어가야 하고 나머지 내용과는 blank line으로 분리되어야 한다. 요약줄은 opening quote와 같은 줄에 있을 수도 있고 다음 줄에 있을 수도 있다. 전체 docstring은 첫번째 줄의 quote와 똑같이 indent를 한다 (아래 예제 참조).

모든 class의 docstring에는 앞뒤로 blank line이 있어야 한다. 이는 Python에서 class의 스타일에 부합하는 형식이다. Function이나 method의 docstring에는 이러한 요구사항이 있지는 않으나, 만약 function이나 method 내부가 blank line을 이용한 부분들로 구분되어 있다면 거기에 맞춰 function이나 method의 docstring에도 앞뒤로 blank line을 넣는게 좋다.

Script의 docstring은 올바르지 않게 또는 "-h"(help) 옵션과 함께 호출 되었을 때 인쇄되는 "사용법" 메시지로 쓰여야 한다. 이러한 docstring은 script의 기능과 명령어 syntax, environment variable 및 파일을 설명해야 한다. 사용법 메시지는 정교할 수도 있고 아니면 모든 옵션과 argument에 대한 간단한 참조만 될 수도 있다.

Module의 docstring은 일반적으로 전달되는 module의 모든 class, exception, function을 각각 한줄로 요약하여 나열해야 한다. Package의 docstring (즉, 패키지의 ``__init __.py`` module의 docstring)은 package 내부의 module과 subpackage도 나열해야 한다 .

Function, method의 docstring은 그 동작을 요약하고 argument, return value, exception 등을 설명해야 한다. Optional argument와 keyword argument 또한 표시해야 한다.

Class의 docstring은 그 동작을 요약하고 public method와 instance variable을 나열해야 한다. Class가 subclass에 의해 쓰이고 subclass에 대한 추가 interface가 있는 경우 이 interface는 별도로 docstring 내부에 나열되어야 한다. Class constructor는 ``__init__`` method의 docstring에 의해 문서화되어야 한다. 개별 method는 자신의 docstring에 의해 문서화되어야 한다.

Class가 subclass로 다른 class의 동작 대부분을 상속하는 경우, docstring에서 이를 언급하고 차이점을 요약해야 한다. Subclass method가 superclass method를 대체하여 superclass method를 호출하지 않을 경우 "override"라는 표현을 사용하며, subclass method가 자체 동작 외에도 superclass method를 추가적으로 호출한다면 "extend"라는 표현을 사용한다.

대문자로 function 또는 method의 argument를 언급하는 Emacs 규약을 *사용하여선 안된다*. Python은 대소문자를 구별하기 때문에 docstring은 올바른 argument 이름을 사용해야 한다. 각 argument는 별도의 개별행에 나열하는 것이 좋다. 예를 들면::

    def complex(real=0.0, imag=0.0):
        """Form a complex number.

        Keyword arguments:
        real -- the real part (default 0.0)
        imag -- the imaginary part (default 0.0)

        """
        if imag == 0.0 and real == 0.0: return complex_zero
        ...

BDFL [3]_ 은 multi-line docstring의 마지막 단락과 closing quote 사이에 blank line을 삽입하는 것을 권장한다. 이렇게 하면 Emacs의 ``fill-paragraph`` 명령을 사용할 수 있다.


Docstring의 Indent 처리
------------------------------

Docstring 처리 도구는 두번째 줄 이후의 모든 non-blank line에서 제일 적은 indent와 같은 크기로 indent를 일정하게 제거한다. 첫 줄에 있는 indent는 무조건 제거된다. 이후 줄에 대한 상대적 indent는 유지된다. Blank line은 docstring 시작과 끝에서 제거되어야 한다.

코드로 된 정확한 알고리즘 구현은 다음과 같다::

    def trim(docstring):
        if not docstring:
            return ''
        # Convert tabs to spaces (following the normal Python rules)
        # and split into a list of lines:
        lines = docstring.expandtabs().splitlines()
        # Determine minimum indentation (first line doesn't count):
        indent = sys.maxint
        for line in lines[1:]:
            stripped = line.lstrip()
            if stripped:
                indent = min(indent, len(line) - len(stripped))
        # Remove indentation (first line is special):
        trimmed = [lines[0].strip()]
        if indent < sys.maxint:
            for line in lines[1:]:
                trimmed.append(line[indent:].rstrip())
        # Strip off trailing and leading blank lines:
        while trimmed and not trimmed[-1]:
            trimmed.pop()
        while trimmed and not trimmed[0]:
            trimmed.pop(0)
        # Return a single string:
        return '\n'.join(trimmed)

다음 예제의 docstring에서는 두개의 newline 문자를 포함해서 세줄 길이이다. 첫번째 줄과 마지막 줄은 비어 있다::

    def foo():
        """
        This is the second line of the docstring.
        """

설명::

    >>> print repr(foo.__doc__)
    '\n    This is the second line of the docstring.\n    '
    >>> foo.__doc__.splitlines()
    ['', '    This is the second line of the docstring.', '    ']
    >>> trim(foo.__doc__)
    'This is the second line of the docstring.'

다듬어진 이후에 다음 docstring들은 동등하다::

    def foo():
        """A multi-line
        docstring.
        """

    def bar():
        """
        A multi-line
        docstring.
        """


참고 문헌 및 각주
======================

.. [1] PEP 256, Docstring Processing System Framework, Goodger
   (http://www.python.org/peps/pep-0256.html)

.. [2] PEP 258, Docutils Design Specification, Goodger
   (http://www.python.org/peps/pep-0258.html)

.. [3] Guido van Rossum, Python's creator and Benevolent Dictator For
   Life.

.. _Docutils: http://docutils.sourceforge.net/

.. _Python Style Guide:
   http://www.python.org/doc/essays/styleguide.html

.. _Doc-SIG: http://www.python.org/sigs/doc-sig/


저작권
=========

이 문서는 공개 도메인에 속한다.


감사 인사
================

"상세" 텍스트는 Guido van Rossum의 `Python Style Guide`_ 에세이에서 거의 그대로 가져왔습니다.

이 문서는 Python Doc-SIG_ 의 아카이브에서의 아이디어를 차용했습니다.



..
   Local Variables:
   mode: indented-text
   indent-tabs-mode: nil
   fill-column: 70
   sentence-end-double-space: t
   End:
