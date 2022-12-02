# Create your grading script here
rm -rf student-submission
git clone $1 student-submission

echo "Cloning..."

cd student-submission

if [ -f ListExamples.java ]
then
    echo "File found. 1/1 points"
else
    echo "File not found. 0/5 Final Grade"
    exit
fi

cp ListExamples.java ..

cd ..

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2> err.txt

if [ $? -ne 0 ]
then
    echo "Compilation Error. 1/5 Final Grade"
    exit
else
    echo "Compilation successful. 1/1 points"
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > grade.txt

PASSED=$(grep -c OK grade.txt)

if [ $PASSED -ne 0 ]
then
    echo "Pass. At least 3/5 Final Grade"
else
    echo "Fail. Less than 3/5 Final Grade"
fi

exit