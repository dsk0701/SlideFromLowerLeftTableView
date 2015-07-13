//
//  ViewController.swift
//  SlideFromLowerLeftTableView
//
//  Created by Daisuke Shiraishi on 2015/07/13.
//
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    var tableView: UITableView?
    var data: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()

        for i in 0...100 {
            data.append(i.description)
        }
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // animateSlide(cell)
        animateSlideFromLowerLeft(cell)
    }
    
    private func animateSlide(cell: UITableViewCell) {
        // 元の Cell の位置を保存
        let originFrame = cell.frame

        cell.backgroundColor = UIColor(red: 0xe6 / 255, green: 0x7e / 255, blue: 0x22 / 255, alpha: 1.0)
        cell.alpha = 0.1
        cell.frame = CGRectMake(originFrame.origin.x - originFrame.size.width / 2, originFrame.origin.y, originFrame.size.width, originFrame.size.height)

        UIView.animateWithDuration(0.6, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            cell.alpha = 1.0
            cell.frame = originFrame
        }) { (result) -> Void in
            println()
        }
    }
    
    private func animateSlideFromLowerLeft(cell: UITableViewCell) {

        let originFrame = cell.frame

        cell.backgroundColor = UIColor(red: 0x34 / 255, green: 0x98 / 255, blue: 0xdb / 255, alpha: 1.0)
        cell.alpha = 0.0
        let angle = 10.0
        // ラジアン = 度 × 円周率 ÷ 180
        let rad = angle * M_PI / 180 * -1.0
        cell.transform = CGAffineTransformMakeRotation(CGFloat(rad))
        cell.frame = CGRectMake(originFrame.origin.x - 20, originFrame.origin.y + 40, originFrame.size.width, originFrame.size.height)

        UIView.animateWithDuration(0.7, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            cell.transform = CGAffineTransformMakeRotation(0.0)
            cell.alpha = 1.0
            cell.frame = originFrame
        }) { (result) -> Void in
            println()
        }
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "Cell"
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        cell.textLabel?.text = data[indexPath.row]

        return cell
    }
}
