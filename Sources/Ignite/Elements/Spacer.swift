//
// Spacer.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

/// Creates vertical space of a specific value.
public struct Spacer: HTML, NavigationItem {
    /// The content and behavior of this HTML.
    public var body: some HTML { self }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// Whether this HTML belongs to the framework.
    public var isPrimitive: Bool { true }

    /// How a `NavigationBar` displays this item at different breakpoints.
    public var navigationBarVisibility: NavigationBarVisibility = .automatic

    /// The amount of space to occupy.
    private var spacingAmount: SpacingType

    /// Whether the spacer is used horizontally or vertically.
    private var axis: Axis = .vertical

    /// Creates a new `Spacer` that uses all available space.
    public init() {
        spacingAmount = .automatic
    }

    /// Creates a new `Spacer` with a size in pixels of your choosing.
    /// - Parameter size: The amount of vertical space this `Spacer`
    /// should occupy.
    public init(size: Int) {
        spacingAmount = .exact(size)
    }

    /// Creates a new `Spacer` using adaptive sizing.
    /// - Parameter size: The amount of margin to apply, specified as a
    /// `SpacingAmount` case.
    public init(size: SpacingAmount) {
        spacingAmount = .semantic(size)
    }

    /// Configures the axis of this spacer.
    /// - Parameter axis: The lateral direction of the spacer.
    /// - Returns: A new `Spacer` with the specified axis.
    func axis(_ axis: Axis) -> Self {
        var copy = self
        copy.axis = .horizontal
        return copy
    }

    /// Renders this element using publishing context passed in.
    /// - Returns: The HTML for this element.
    public func markup() -> Markup {
        if spacingAmount == .automatic {
            Section {}
                .class(axis == .horizontal ? "ms-auto" : nil)
                .class(axis == .vertical ? "mt-auto" : nil)
                .markup()
        } else if case let .semantic(spacingAmount) = spacingAmount {
            Section {}
                .margin(axis == .vertical ? .top : .leading, spacingAmount)
                .markup()
        } else if case let .exact(int) = spacingAmount {
            Section {}
                .frame(width: axis == .horizontal ? .px(int) : nil)
                .frame(height: axis == .vertical ? .px(int) : nil)
                .markup()
        } else {
            fatalError("Unknown spacing amount: \(String(describing: spacingAmount))")
        }
    }
}
