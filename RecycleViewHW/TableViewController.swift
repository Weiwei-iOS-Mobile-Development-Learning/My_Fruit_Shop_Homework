//
//  TableViewController.swift
//  RecycleViewHW
//
//  Created by 楊智崴 on 2020/10/30.
//

import UIKit

class TableViewController: UITableViewController {
    
    var fruits = ["Watermelon","Apple","Orange","Strawberry","Pear"]
    
    var price = ["500","100","90","200","150"]
    var priceInInt = [500,100,90,200,150]
    
    var fruitImages = ["Watermelon","Apple","Orange","Strawberry","Pear"]
    
    var fruitChecked = Array(repeating: false, count: 5)
    
    @IBOutlet var outputPrice: UILabel!
    
    func addCheckedNumbers(priceIntArray: [Int]) -> Int {   //一個裝數字的空陣列傳入，回傳加總後的值
          var ans = 0           //設定價錢總和
          if priceIntArray.count == 0{  //如果沒有值傳入陣列，給0
              return 0
          }
          else{
              for i in 0...priceIntArray.count-1{   //加陣列裡的所有值
                  ans += priceIntArray[i]
              }
              return ans
          }
      }

    var arrayforChecked = [Int]()      //設定一個空的Int陣列來放被勾選得值

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fruits.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        
        // Configure the cell...
        cell.fruitLabel.text = fruits[indexPath.row]
        cell.priceLabel.text = price[indexPath.row]
        cell.thumbnailImageView?.image = UIImage(named: fruitImages[indexPath.row])
        
        
        if fruitChecked[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.accessoryType = fruitChecked[indexPath.row] ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "Welcome to HAHA FRUITS 🍉🍎🍊🍓🍐", preferredStyle: .actionSheet)
        
        // Check-in action
        let checkInAction = UIAlertAction(title: "BUY!", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.fruitChecked[indexPath.row] = true
            
            //Output total price
            
            let temp = self.priceInInt[indexPath.row]           //將勾選到的價錢值(Int)存入temp
            self.arrayforChecked.append(temp)        //append是指將()裡的數從後面放入陣列
            let answer = self.addCheckedNumbers(priceIntArray: self.arrayforChecked)    //將加總直傳入answer
            self.outputPrice.text = "Total Prices = " + String(answer)
            
            //ans += Int(self.price[indexPath.row])!
        })
        optionMenu.addAction(checkInAction)
        
        let UndocheckInAction = UIAlertAction(title: "REFUND!", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            if self.fruitChecked[indexPath.row]{
                cell?.accessoryType = .none
                self.fruitChecked[indexPath.row] = false
                
                
                //Output total price 需要確定該cell有被勾選才執行，不然會錯誤
                
                let temp = self.priceInInt[indexPath.row]   //將取消勾選到的價錢值(Int)存入temp
                for i in 0...self.arrayforChecked.count-1{  //去看存值得陣列裡有沒有取消勾選的temp值
                    if self.arrayforChecked[i] == temp{     //如果有就把該值設為0
                        self.arrayforChecked[i] = 0
                    }
                }
                let answer = self.addCheckedNumbers(priceIntArray: self.arrayforChecked)
                self.outputPrice.text = "Total Prices = " + String(answer)
            }
            
            
        })
        optionMenu.addAction(UndocheckInAction)
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "I want BANANAS😤", style: .cancel, handler: nil)
        
        optionMenu.addAction(cancelAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        
        // Deselect a row
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        /*
        func addprice(action: UIAlertAction) -> Int{
            let add = Int(price[indexPath.row])!
            ans += add
            return ans
        }
        func subtractprice(action: UIAlertAction) -> Int{
            let sub = Int(price[indexPath.row])!
            ans -= sub
            return ans
        }
         */
        
        
       //ans += addprice(action: checkInAction)
        
        //Output price sum
        /*
        var ans = 0
        if fruitChecked[indexPath.row] == true {
            ans += Int(price[indexPath.row])!
        }
        else{
            ans -= Int(price[indexPath.row])!
        }
        outputPrice.text = "Total Prices = " + String(ans)*/
        
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}


