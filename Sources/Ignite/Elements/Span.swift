//
// Span.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

/// An inline subsection of another element, useful when you need to style
/// just part of some text, for example.
public struct Span: InlineElement, NavigationItem, FormItem {
    /// The content and behavior of this HTML.
    public var body: some InlineElement { self }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// Whether this HTML belongs to the framework.
    public var isPrimitive: Bool { true }

    /// The contents of this span.
    private var contents: any InlineElement

    /// How a `NavigationBar` displays this item at different breakpoints.
    public var navigationBarVisibility: NavigationBarVisibility = .automatic

    /// Creates a span with no content. Used in some situations where
    /// exact styling is performed by Bootstrap, e.g. in Carousel.
    public init() {
        self.contents = EmptyInlineElement()
    }

    /// Creates a span from one `InlineElement`.
    /// - Parameter singleElement: The element you want to place
    /// inside the span.
    public init(_ singleElement: some InlineElement) {
        self.contents = singleElement
    }

    /// Creates a span from an inline element builder that returns an array of
    /// elements to place inside the span.
    /// - Parameter contents: The elements to place inside the span.
    public init(@InlineElementBuilder contents: () -> some InlineElement) {
        self.contents = contents()
    }

    /// Renders this element using publishing context passed in.
    /// - Returns: The HTML for this element.
    public func markup() -> Markup {
        let contentHTML = contents.markupString()
        return Markup("<span\(attributes)>\(contentHTML)</span>")
    }
}
