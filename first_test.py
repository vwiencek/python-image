import allure
import logging

logging.getLogger().setLevel(logging.DEBUG)



# content of test_sample.py
def func(x):
    return x + 1


@allure.description("""Test description""")
def test_answer():
    assert func(3) == 5


@allure.title("Test Authentication")
@allure.description("This test attempts to log into the website using a login and a password. Fails if any error happens.\n\nNote that this test does not test 2-Factor Authentication.")
@allure.tag("NewUI", "Essentials", "Authentication")
@allure.severity(allure.severity_level.CRITICAL)
@allure.label("owner", "John Doe")
@allure.link("https://dev.example.com/", name="Website")
@allure.issue("AUTH-123")
@allure.testcase("TMS-456")
def test_answers():
    assert func(3) == 9

# content of test_verbosity_example.py
def test_ok():
    pass


def test_words_fail():
    print("coucou")
    logging.debug("debug dd")
    logging.info("debug dd")
    logging.error("error")
    fruits1 = ["banana", "apple", "grapes", "melon", "kiwi"]
    fruits2 = ["banana", "apple", "orange", "melon", "kiwi"]
    assert fruits1 == fruits2


def test_numbers_fail():
    number_to_text1 = {str(x): x for x in range(5)}
    number_to_text2 = {str(x * 10): x * 10 for x in range(5)}
    assert number_to_text1 == number_to_text2


def test_long_text_fail():
    long_text = "Lorem ipsum dolor sit amet " * 10
    assert "hello world" in long_text