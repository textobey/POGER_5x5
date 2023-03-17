//
//  UITableView+.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/16.
//

import UIKit

extension UITableView {
    /**
     * Returns all cells in a table
     * ## Examples:
     * tableView.cells // array of cells in a tableview
     */
    public var cells: [UITableViewCell] {
        (0..<self.numberOfSections).indices.map { (sectionIndex: Int) -> [UITableViewCell] in
            (0..<self.numberOfRows(inSection: sectionIndex)).indices.compactMap { (rowIndex: Int) -> UITableViewCell? in
                self.cellForRow(at: IndexPath(row: rowIndex, section: sectionIndex))
            }
        }.flatMap { $0 }
    }
}
