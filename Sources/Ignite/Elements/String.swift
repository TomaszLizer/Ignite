//
// String.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

/// A small String extension that allows strings to be used directly inside HTML.
/// Useful when you don't want your text to be wrapped in a paragraph or similar.
extension String: InlineElement, FormItem {
    /// The content and behavior of this HTML.
    public var body: some InlineElement { self }

    /// Renders this element using publishing context passed in.
    /// - Returns: The HTML for this element.
    public func markup() -> Markup {
        Markup(self)
    }
}
