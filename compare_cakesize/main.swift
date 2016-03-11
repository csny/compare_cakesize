//
//  main.swift
//  compare_cakesize
//
//  Created by macbook on 2016/03/11.
//  Copyright © 2016年 macbook. All rights reserved.
//

import Foundation

// 標準入力の準備
extension String: CollectionType {}
func readInts() -> [Int] {
    return readLine()!.split(" ").map { Int($0)! }
}

// 標準入力されたデータの取り込み
// 1行目をCAKEINFOに格納
let CAKEINFO :[Int] = readInts()
let CUTNUM :Int = CAKEINFO[3]

// 2行目以降の切れ目情報をcutLineに格納
var cutLine :[[Int]] = [[Int]](count: CUTNUM, repeatedValue: [Int](count: 2, repeatedValue: 0))
for (var row=0,n=CUTNUM;row<n;row++) {
    let arrayRow :[Int] = readInts()
    for (var column=0,n=2;column<n;column++) {
        cutLine[row][column] = arrayRow[column]
    }
}

//print(CAKEINFO)
//print(arrayCutline)

// ケーキのサイズを計算しやすくするため、
// 切れ目の位置を縦:cutVertiと横:cutHorizに格納
var countv :Int = 0
for (var i=0,n=CUTNUM;i<n;i++) {
    if (cutLine[i][0] == 0) {
        countv++
    }
}
var cutVerti :[Int] = [Int](count: countv,repeatedValue:0)
var cutHoriz :[Int] = [Int](count: CUTNUM - countv,repeatedValue:0)
var v :Int = 0
var h :Int = 0
for (var i=0,n=CUTNUM;i<n;i++) {
    if (cutLine[i][0] == 0) {
        cutVerti[v] = cutLine[i][1]
        v++
    } else {
        cutHoriz[h] = cutLine[i][1]
        h++
    }
}

// 手抜きでソート用の関数使っちゃう＜大きい順に並べる＞
cutVerti.sortInPlace {$1 < $0}
cutHoriz.sortInPlace {$1 < $0}
// ケーキの外枠も配列に挿入しちゃう
cutVerti.insert(CAKEINFO[0], atIndex:0)
cutVerti.insert(0, atIndex:cutVerti.count)
cutHoriz.insert(CAKEINFO[1], atIndex:0)
cutHoriz.insert(0, atIndex:cutHoriz.count)
// ケーキ片の横の長さpiecelengthXと縦の長さpiecelengthYに格納
var piecelengthX :[Int] = [Int](count:cutVerti.count-1, repeatedValue:0)
var piecelengthY :[Int] = [Int](count:cutHoriz.count-1, repeatedValue:0)
for (var i=0,n=cutVerti.count-1;i<n;i++) {
    piecelengthX[i] = cutVerti[i] - cutVerti[i+1]
}
for (var i=0,n=cutHoriz.count-1;i<n;i++) {
    piecelengthY[i] = cutHoriz[i] - cutHoriz[i+1]
}

// ケーキ片の縦横を片っ端から掛け算して、より小さい物を更新
var smallestPiece :Int = 999999999
for (var i:Int=0,n=piecelengthX.count;i<n;i++) {
    for (var j:Int=0,n=piecelengthY.count;j<n;j++) {
        if (piecelengthX[i]*piecelengthY[j]*CAKEINFO[2]<smallestPiece) {
            smallestPiece = piecelengthX[i]*piecelengthY[j]*CAKEINFO[2]
        }
    }
}

print(smallestPiece)