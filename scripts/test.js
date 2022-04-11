//find index of array that has #
function compareStrings(s1, s2) {
    let arr1 = Array.from(s1);
    let arr2 = Array.from(s2);
    var search= "#";
    function finder(arr, str) {
    return arr.reduce((p, c, i) => {
      if (c.includes(str)) p.push(i);
      return p;
    }, []);
  }
  
let backspace_index1= finder(arr1, search);
let backspace_index2= finder(arr2, search);

//compare that the index is same index between 2 arrays
const result1 = arr1.filter((str,idx) => {
    if(backspace_index1.includes(idx)){
        if(arr1[idx-1]!=""){
        arr1[idx]=""
        arr1[idx-1]=""
        } else {
            arr1[idx]=""
        }
    }
})

const result2 = arr2.filter((str,idx) => {
   
    if(backspace_index2.includes(idx)){
        if(arr2[idx+1]=="#" && arr2[idx]=="#"){
        arr2[idx]=""
        arr2[idx-2]=""
        arr2[idx-1]=""
        arr2[idx+1]=""
        }else{
        arr2[idx]=""
        arr2[idx-1]=""
        }
    }
})

//make array back to string
let new_s1 =arr1.join('');
let new_s2 =arr2.join('');

//if same string return 1
let final_result;
if (new_s1 == new_s2) {
    final_result =1;
    } else {
    final_result= 0;
    }
    
    return final_result;

}

let s1= "yf#c#"
let s2= "yy#k#pp##"
console.log(compareStrings(s1,s2));