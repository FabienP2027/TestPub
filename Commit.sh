echo "Clean"
echo "" > .tmpMessage
for i in `git ls-files --modified`;
do
  echo $i;
  dos2unix $i;
  echo "FILE:"$i >> .tmpMessage
  git diff $i | grep "^[-+]" | grep -v "DRILL"| grep -v "REPEAT" | grep -v "\-\-\- " | grep -v "\+\+\+ " | grep -v SCHEDULE >> .tmpMessage
done

git add -A .

if [ -s .tmpMessage ]; then
  cat .tmpMessage
else
  echo "Schedule Change only" > .tmpMessage
fi

git commit -F .tmpMessage

echo "STATUS:"
git status
