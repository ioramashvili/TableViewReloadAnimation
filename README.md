<h1 align="center">Reload tableview with animation</h1>

<table>
<tr>
<th>right to left</th>
<th>bottom to top</th>
<th>left to right</th>
<th>top to bottom</th>
</tr>
<tr>
<td><img src="gifs/left.gif"/></td>
<td><img src="gifs/top.gif"/></td>
<td><img src="gifs/right.gif"/></td>
<td><img src="gifs/bottom.gif"/></td>
</tr>
</table>

## Example

Download project and play

## Requirements

- iOS 9.0+

## Usage

```swift
// normal animation
tableView.reloadData(with: .simple(duration: 0.45, direction: .left(useCellsFrame: true), constantDelay: 0))

// spring animation
tableView.reloadData(with: .spring(duration: 0.45, damping: 0.65, velocity: 1, direction: .left(useCellsFrame: false), constantDelay: 0))

// rotation
tableView.reloadData(with: .spring(duration: 0.45, damping: 0.65, velocity: 1, direction: .rotation(angle: Double.pi / 2), constantDelay: 0))
```
