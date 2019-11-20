# To use this, move this file out of the repository
# Clone the CanvasCompetition repository from Github

rm -rf ./CanvasDemo/examples/*
rm ./CanvasDemo/CNAME
rm ./CanvasDemo/index.html
touch ./CanvasDemo/index.html
touch ./CanvasDemo/CNAME
echo -e "canvas.zense.co.in" >> ./CanvasDemo/CNAME

echo -e "<!DOCTYPE html>\n<html lang="en">\n\t<head>\n\t\t<title>Zense HacKnight 2k19</title>\n\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"></link>\n\t" >> ./CanvasDemo/index.html

echo -e "\t<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\" integrity=\"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\" crossorigin=\"anonymous\">" >> ./CanvasDemo/index.html
echo -e "\t<link rel =\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css\" integrity=\"sha256-46qynGAkLSFpVbEBog43gvNhfrOj+BmwXdxFgVK/Kvc=\" crossorigin=\"anonymous\" /></head>" >> ./CanvasDemo/index.html
echo -e "\t<link href=\"https://fonts.googleapis.com/css?family=Ubuntu|ZCOOL+QingKe+HuangYou&display=swap\" rel=\"stylesheet\">" >> ./CanvasDemo/index.html

echo -e "\t<body>\n\t\t<header id=\"title\" class=\"ml-auto mr-auto\"><img src=\"./zense.png\" alt=\"Zense\" /><br />HacKnight 2k19</header>\n" >> ./CanvasDemo/index.html

echo -e "\t\t<label for=\"#links\" id=\"label\">Some examples for you to look at !</label>" >> ./CanvasDemo/index.html
echo -e "\t\t<div class=\"col-12 col-lg-9 ml-lg-auto mr-lg-auto\">" >> ./CanvasDemo/index.html

echo -e "\n\t\t<div class=\"card border-0\">\n\t\t\t<div class=\"card-body\">\n\t\t\t<p class=\"guide mr-auto\">Click to view example</p>\n\t\t\t<p class=\"guide float-right\">Link to code</p>\n\t\t</div>\n\t\t</div>" >> ./CanvasDemo/index.html

cd Canvas-Competition

git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all

git for-each-ref --format='%(refname)__%(authorname)' refs/heads/ | grep 'examples/.*' | while read branchRef; do
  tempRef=${branchRef#*refs/heads/}
  branchName=${tempRef%%__*}
  authorName=${branchRef#*__}
  echo "ref: "$tempRef 
  echo $branchName
  git checkout $branchName
  git pull origin $branchName
  git archive --format=tar --prefix="$branchName/" "$branchName" | tar -C../CanvasDemo -x
  echo -e "\n\t\t<div class=\"card border-0\">" >> ../CanvasDemo/index.html
  echo -e "\t\t\t<div class=\"card-body\">\n\t\t\t\t<a href=\"./$branchName/index.html\" class=\"link mr-auto\" target=\"_blank\">${branchName:9}</a> <br>" >> ../CanvasDemo/index.html
  echo -e "\t\t\t\t<a href=\"https://github.com/zense/Canvas-Competition/tree/$branchName\" class=\"link ml-auto\" target=\"_blank\"><i class=\"fab fa-github\"></i></a><br>\n\t\t\t</div>" >> ../CanvasDemo/index.html
  echo -e "\t\t</div>" >> ../CanvasDemo/index.html
done

git for-each-ref --format='%(refname)__%(authorname)' refs/heads/ | grep 'HacKnight2K19/.*' | while read branchRef; do
  tempRef=${branchRef#*refs/heads/}
  branchName=${tempRef%%__*}
  authorName=${branchRef#*__}
  echo "ref: "$tempRef 
  echo $branchName
  git checkout $branchName
  git pull origin $branchName
  git archive --format=tar --prefix="$branchName/" "$branchName" | tar -C../CanvasDemo -x
  echo -e "\n\t\t<div class=\"card border-0\">" >> ../CanvasDemo/index.html
  echo -e "\t\t\t<div class=\"card-body\">\n\t\t\t\t<a href=\"./$branchName/index.html\" class=\"link mr-auto\" target=\"_blank\">${branchName:13}</a> <br>" >> ../CanvasDemo/index.html
  echo -e "\t\t\t\t<a href=\"https://github.com/zense/Canvas-Competition/tree/$branchName\" class=\"link ml-auto\" target=\"_blank\"><i class=\"fab fa-github\"></i></a><br>\n\t\t\t</div>" >> ../CanvasDemo/index.html
  echo -e "\t\t</div>" >> ../CanvasDemo/index.html
done

echo -e "\n\t\t</div>\n\t\t\t\n\t\t<br /><br /><br /><br /><br />\n\t\t<footer id=\"ending\">Zense 2019</footer></body>\n</html>" >> ../CanvasDemo/index.html

cd ../CanvasDemo
git add .
git commit -m "Updated the frontend and the script" && git push -u origin master
