//
//  ViewController.swift
//  MDLTest
//
//  Created by Abhishek Sood on 6/21/22.
//

import UIKit

private extension String {
    static let identifier = "table_cell_id"
}

class ViewController: UIViewController {
    lazy var tableView: UITableView = {
      return UITableView()
    }()
    
    let urlsToTry: [URL] = {
        var urls = [URL]()
        urls.append(URL(string: "itms-bookss://itunes.apple.com/us/book/run-away/id1406238792?mt=11")!)
        urls.append(URL(string: "https://www.walmart.com/ip/seort/218615558")!)
        urls.append(URL(string: "https://www.amazon.com/ip/seort/218615558")!)
        urls.append(URL(string: "https://www.this-ap--shoudntexist.com/ip/seort/218615558")!)
        
        return urls
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: .identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        urlsToTry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .identifier, for: indexPath)
        cell.textLabel?.text = "Open \(urlsToTry[indexPath.row].absoluteString)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tryToOpen(indexPath)
    }
    
    private func tryToOpen(_ indexPath: IndexPath) {
        let url = urlsToTry[indexPath.row]
        print("opening.. \(url.absoluteString)")
        print("Can open URL: \(UIApplication.shared.canOpenURL(url))")
        UIApplication.shared.open(url,
                                  options: [.universalLinksOnly: false]) { success in
            print("open url success: \(success)")
        }
    }
}
