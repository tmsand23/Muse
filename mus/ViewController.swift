//
//  ViewController.swift
//  mus
//
//  Created by tyler sand on 6/13/19.
//  Copyright © 2019 tyler sand. All rights reserved.
//

import Cocoa
import AVFoundation
import Darwin
//TODO: get val to play when clicked
extension NSOpenPanel {
    var selectUrl: URL? {
        title = "Select Image"
        allowsMultipleSelection = false
        canChooseDirectories = false
        canChooseFiles = true
        canCreateDirectories = false
        allowedFileTypes = ["jpg","png","pdf","pct", "bmp", "tiff"]  // to allow only images, just comment out this line to allow any file type to be selected
        return runModal() == .OK ? urls.first : nil
    }
    var selectUrls: [URL]? {
        title = "Select Images"
        allowsMultipleSelection = true
        canChooseDirectories = false
        canChooseFiles = true
        canCreateDirectories = false
        allowedFileTypes = ["jpg","png","pdf","pct", "bmp", "tiff"]  // to allow only images, just comment out this line to allow any file type to be selected
        return runModal() == .OK ? urls : nil
    }
}





class ViewController: NSViewController {

    var player: AVPlayer?
   // var fileName: String?
    @IBOutlet weak var musicList: NSPopUpButton!
    
    @IBOutlet weak var label: NSTextField!
    let dialog = NSOpenPanel();
    var itemSelect:Bool?=false

    @IBOutlet weak var tableView: NSTableView!
    var path: String?//: String?
    
    @IBOutlet weak var tableColumn: NSTableColumn!
    @IBOutlet weak var firstName: NSTableColumn!
    
    @IBOutlet weak var delete: NSButton!
    //var row: Int?
   // let qplayer = AVQueuePlayer()
    // @IBOutlet weak var tableView: NSTableView!
 var data: [[String: String]] = [[:]]
     var dat: [[String: String]] = [[:]]
    var aud: AVAudioPlayer?
    //var data: [[String]]
    @IBOutlet weak var songSlider: NSSlider!
    
    @IBOutlet weak var volumeSlider: NSSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //test
       
        //test
       
        data = [
            [
                "firstName" : "PlaceHolder",//"select a song"
                "lastName"  : "Lyod",
                "mobileNumber" : "5532612"
            ]/*,
            [
                "firstName" : "Gabriel",
                "lastName"  : "Bota",
                "mobileNumber" : "54329987"
            ],
            [
                "firstName" : "Olga",
                "lastName"  : "Morales",
                "mobileNumber" : "53122543"
            ]*/
        ]
        data.remove(at: 0)//removes placeholder
     
        //reload
      //  self.tableView.reloadData()        //test
        //tableView.reloadData()
       
        
        
    }
    
    //test
    @IBAction func openFile(_ sender: NSButton){
        dialog.title                   = "Choose a .txt file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        // dialog.allowedFileTypes        = ["mp3"];
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
               // let path = result?.path
               path = result?.path
                
             //   let selectedItem:String? = musicList.titleOfSelectedItem
                
                //let fileName = String(path.dropFirst(82))
                //test
                itemSelect! = true
              // guard let cell = tableView.makeView(withIdentifier: firstName!.identifier, owner: self) as? NSTableCellView else { return  }
                
                
              //  cell.textField?.stringValue = path!
                
                
                //let url = Bundle.main.url(forResource: path, withExtension: "mp3")!
                
                //test
                
               // let url = URL(fileURLWithPath: path!)
                //let playerItem = AVPlayerItem(url: url)
                //player = AVPlayer(playerItem: playerItem)
              // player!.play()
                //test
                
                
                // print(path!)
               // label.stringValue = path!
                
                // musicList.insertItem(withTitle: path!, at:0)
                //append data when file selected
                
            //  data[0] = ["firstName" : path!]
               data.append(["firstName" : path!])
               
                
                print(data[0])
               tableView.reloadData()
               // self.tableView.reloadData()
                //   musicList.addItem(withTitle: path!)
              // print( tableView.tableColumns)
                
                
                
                // path.dropFirst(8)
                // print(path)
                //test
                
                
                //test
            }
            // filename_field.stringValue = path
            
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    func deleteRows(_ notification: Notification){
        guard let table = notification.object as? NSTableView else {
            return
        }
        let row = table.selectedRow
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (data.count)
    }
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let table = notification.object as? NSTableView else {
            return
        }
        let row = table.selectedRow
       // let value = table.cell
       //print(data[0].values)//values
        //var val: String?
        
        
        
        
        for val in Array(data[row].values) {//values
            print("\(val)")
          // player?.play()
            let url = URL(fileURLWithPath: val)
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            //test
            
            //test
            player?.play()
            
            //test
           
            songSlider.isContinuous = true
            
           
            let currentTime = Int(self.player!.currentTime().value)// + 1
            
             Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            songSlider.integerValue = currentTime
           label.stringValue = "song:[\(currentTime)]"
            
        }
        //play val when selected
       
        
        print(row)
        
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let person = data[row]
        
       guard let cell = tableView.makeView(withIdentifier: firstName!.identifier, owner: self) as? NSTableCellView else { return nil }//tableColumn
        
          cell.textField?.stringValue = person[firstName!.identifier.rawValue]!//? ! rawValue
        //cell should equal path of mp3
        //cell.textField?.stringValue = "song"
       //test
       //tableView.action = #selector(onItemClicked)
        
           //cell.textField?.stringValue = "fart"
            //cell.textField?.stringValue = path!//path!
        
        //cell.textField?.stringValue = path!
         //cell.textField?.stringValue = "fat"
       
        
           return cell
    }
    @objc func fireTimer() {
        print("Timer fired!")
        //songSlider.minValue = 0.0
      //  songSlider.maxValue = 1.0
        
        let currentTime = Int(self.player!.currentTime().seconds)//seconds
        
       // Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        label.stringValue = "song:[\(currentTime)]"
        songSlider.integerValue = currentTime
        
    }
    //test
    
    @IBAction func delete(_ sender: NSButton){
        
       //data.remove(at: 0)
       
      /*  let row = tableView.selectedRow
        if let index = data.firstIndex(of:data[row]) {
            
            data.remove(at: index)
            let indexSet = IndexSet(integer:index)
            tableView.removeRows(at:indexSet, withAnimation:.effectFade)
        }
         
         
        print("delete")*/
       // let row = tableView.row(for: sender)
       
      //  data.remove(at: row)
        //tableView.removeRows(at: IndexSet(integer:0),withAnimation: .effectFade)
       // tableView.reloadData()
        
        /*
        if let index = data.firstIndex(of: data[0]) {
            data.remove(at: index)
            let indexSet = IndexSet(integer:index)
          // tableView.selectRowIndexes(indexSet, byExtendingSelection: false)
           // tableView.removeRows(at:indexSet, withAnimation:.effectFade)
        }*/
        
        //data.remove(at: row!)
       // tableView.removeRows(at: IndexSet(integer:row!),withAnimation: .effectFade)
       // let row = tableView.row(for: sender)
      //  data.remove(at:row)
       // tableView.removeRows(at: IndexSet(integer:row), withAnimation:.effectFade)
        // do other things with the row
        
        print("hi")
    }
    //test
 
    
    //open window on right click
    override func rightMouseDown(with theEvent: NSEvent) {
        let point = tableView.convert(theEvent.locationInWindow, from: nil)
        let row = tableView.row(at: point)//let
        print("right click")
        print(row)
       /* let storyboard:NSStoryboard = NSStoryboard(name: "Menu", bundle: nil)
        guard let controller:NSWindowController = storyboard.instantiateController(withIdentifier: "Menu") as? NSWindowController else { return /*or handle error*/ }
        controller.showWindow(self)*/
        //test
       player!.pause()
      // player!.replaceCurrentItem(with: nil)
       
        
        let a = NSAlert()
        a.messageText = "Delete this song?"
        a.informativeText = "Are you sure you want to delete this song?"
        a.addButton(withTitle: "Delete")
        a.addButton(withTitle: "Cancel")
        a.alertStyle = NSAlert.Style.critical
        
        a.beginSheetModal(for: self.view.window!, completionHandler: { (modalResponse) -> Void in
            if modalResponse == NSApplication.ModalResponse.alertFirstButtonReturn {
                
               self.tableView.reloadData()
               self.data.remove(at: row)
                
                self.tableView.removeRows(at: IndexSet(integer:row),withAnimation: .effectFade)
                
                    print("Document deleted")
                    
                
            }
            else{//pressed cancel
                self.player!.play()
            }
            
        })
        
        
        //test
       //data.remove(at: row)
       // tableView.removeRows(at: IndexSet(integer:row),withAnimation: .effectFade)
        
    }
    //test
    @IBAction func songSlider(_sender: NSSlider){
      // songSlider.minValue = 0.0
      
       
        
     let seekDuration: Float64 = 1
       
        
        //forward skip
      /* guard let duration  = player!.currentItem?.duration else{//song length
            return
        }
        let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())//converts to seconds
        var newTime = playerCurrentTime + seekDuration//+
        
        
        //test
        if newTime < (CMTimeGetSeconds(duration) - seekDuration) {
            
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
            
        }*/
        //seek
        
        let seconds : Int64 = Int64(songSlider.integerValue)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)

      //backward skip
      /*  let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
        var newTime = playerCurrentTime - seekDuration
        
        if newTime < 0 {
            newTime = 0
        }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player!.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        */

        
        
    }
    
    
    
    @IBAction func sliderValueChanged(_sender: NSSlider){
       
        volumeSlider.minValue = 0.0
        volumeSlider.maxValue = 1.0
        volumeSlider.altIncrementValue = 0.1
        let amount = volumeSlider.floatValue
        label.stringValue = "slider volume: [\(amount)]"
       // var selectedValue = Float(amount)
        player!.volume = amount
        
        //label.text = "\(slider.value)"
    }
    
    @IBAction func exitProgram(_ sender: NSButton){
        exit(0)
        
    }
    
    
    @IBAction func stop(_ sender: NSButton){
        player!.pause()
        
    }
    @IBAction func resume(_ sender: NSButton){
        
        
        player!.play()
        
    }
    
    //test
   @IBAction func play(_ sender: NSButton){
       /* let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }*/
    var item = musicList.selectedItem
    print(item)
   /* let url = URL(fileURLWithPath: item!)
    let playerItem = AVPlayerItem(url: url)
    player = AVPlayer(playerItem: playerItem)
    player!.play()*/
    
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    
  /*  func numberOfRows(in tableView: NSTableView) -> Int {
        return (data.count)
    }*/
    /*
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let person = data[row]
        
        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
     //   cell.textField?.stringValue = person[tableColumn!.identifier.rawValue]!//? !
        //cell should equal path of mp3
        if(itemSelect == true){
            cell.textField?.stringValue = "fat"//path!
        }
        
       // cell.textField?.stringValue = "fat"
        
        
        return cell
    }*/
}
