//
//  ListViewController.swift
//  ContainerView1
//
//  Created by Tianbo Qiu on 12/27/22.
//

import UIKit

class ListViewController: UITableViewController {
    var moodEntries: [MoodEntry] = []
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = moodEntries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = "I was \(entry.mood.name)"
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: entry.timestamp, dateStyle: .medium, timeStyle: .short)
        cell.imageView?.image = entry.mood.image
        return cell
    }
    
}

extension ListViewController: MoodsConfigurable {
    func add(_ entry: MoodEntry) {
        moodEntries.insert(entry, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}
