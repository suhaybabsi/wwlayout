//
// ===----------------------------------------------------------------------===//
//
//  Layout+RTL.swift
//
//  Created by Suhaib Alabsi on 22/02/2021
//
// ===----------------------------------------------------------------------===//
//

import Foundation

public enum LayoutRtlFillEdge {
    case leading
    case trailing
    case top
    case bottom
}

extension Layout {
    
    // MARK: - Fill with optional axis
    
    /// Set the view so it fills another view.
    /// Will constrain the edges (leading, top, bottom, trailing) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func rtlFill(_ other: Anchorable,
                        axis: LayoutAxis = .xy,
                        inset: Insets? = nil,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        let inset = inset ?? .zero
        if axis == .x || axis == .xy {
            leading(.equal, to: other, offset: inset.left, priority: priority, tag: tag, active: active)
            trailing(.equal, to: other, offset: -inset.right, priority: priority, tag: tag, active: active)
        }
        
        if axis == .y || axis == .xy {
            top(.equal, to: other, offset: inset.left, priority: priority, tag: tag, active: active)
            bottom(.equal, to: other, offset: -inset.right, priority: priority, tag: tag, active: active)
        }
        return self
    }
    
    /// Set the view so it fills another view.
    /// Will constrain the edges (leading, top, bottom, trailing) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func rtlFill(_ other: Anchorable,
                        axis: LayoutAxis = .xy,
                        inset: CGFloat,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        return rtlFill(other, axis: axis, inset: Insets(inset), priority: priority, tag: tag, active: active)
    }
    
    /// Set the view so it fills special anchors.
    /// Will constrain the edges (leading, top, bottom, trailing) of the target view to the edges of `special`, based on the `axis` parameter.
    @discardableResult
    public func rtlFill(_ special: SpecialAnchorable,
                        axis: LayoutAxis = .xy,
                        inset: Insets? = nil,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        
        let inset = inset ?? .zero
        if axis == .x || axis == .xy {
            leading(.equal, to: special, edge: .leading, offset: inset.left, priority: priority, tag: tag, active: active)
            trailing(.equal, to: special, edge: .trailing, offset: -inset.right, priority: priority, tag: tag, active: active)
        }
        if axis == .y || axis == .xy {
            top(.equal, to: special, edge: .top, offset: inset.top, priority: priority, tag: tag, active: active)
            bottom(.equal, to: special, edge: .bottom, offset: -inset.bottom, priority: priority, tag: tag, active: active)
        }
        return self
    }
    
    /// Set the view so it fills another view.
    /// Will constrain the edges (leading, top, bottom, trailing) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func rtlFill(_ special: SpecialAnchorable,
                        axis: LayoutAxis = .xy,
                        inset: CGFloat,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        return rtlFill(special, axis: axis, inset: Insets(inset), priority: priority, tag: tag, active: active)
    }
    
    // MARK: - Fill except one edge
    
    /// Set the view so it fills another view - excluding one edge.
    /// Will constrain the edges (leading, top, bottom, trailing) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func rtlFill(_ other: Anchorable,
                        except: LayoutRtlFillEdge,
                        inset: Insets? = nil,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        let inset = inset ?? .zero
        if except != .leading {
            leading(.equal, to: other, edge: .leading, offset: inset.left, priority: priority, tag: tag, active: active)
        }
        if except != .trailing {
            trailing(.equal, to: other, edge: .trailing, offset: -inset.right, priority: priority, tag: tag, active: active)
        }
        if except != .top {
            top(.equal, to: other, edge: .top, offset: inset.top, priority: priority, tag: tag, active: active)
        }
        if except != .bottom {
            bottom(.equal, to: other, edge: .bottom, offset: -inset.bottom, priority: priority, tag: tag, active: active)
        }
        return self
    }
    
    // Set the view so it fills another view - excluding one edge.
    /// Will constrain the edges (leading, top, bottom, trailing) of the target view to the edges of `otherView`, based on the `axis` parameter.
    @discardableResult
    public func rtlFill(_ other: SpecialAnchorable,
                        except: LayoutRtlFillEdge,
                        inset: Insets? = nil,
                        priority: LayoutPriority? = nil,
                        tag: Int? = nil,
                        active: Bool? = nil) -> Layout {
        let inset = inset ?? .zero
        if except != .leading {
            leading(.equal, to: other, edge: .leading, offset: inset.left, priority: priority, tag: tag, active: active)
        }
        if except != .trailing {
            trailing(.equal, to: other, edge: .trailing, offset: -inset.right, priority: priority, tag: tag, active: active)
        }
        if except != .top {
            top(.equal, to: other, edge: .top, offset: inset.top, priority: priority, tag: tag, active: active)
        }
        if except != .bottom {
            bottom(.equal, to: other, edge: .bottom, offset: -inset.bottom, priority: priority, tag: tag, active: active)
        }
        return self
    }
    
    @discardableResult
    public func rtlFillWidth(of other: Anchorable,
                             inset: Insets? = nil,
                             maximum: CGFloat,
                             alignTo edge: LayoutXEdge = .center,
                             priority: LayoutPriority? = nil,
                             tag: Int? = nil,
                             active: Bool? = nil) -> Layout {
        let inset = inset ?? .zero
        let priority = priority ?? LayoutPriority(rawValue: 1000)
        rtlFill(other, axis: .x, inset: inset, priority: priority - 1, tag: tag, active: active)
        width(.lessOrEqual, to: maximum, priority: priority, tag: tag, active: active)
        switch edge {
        case .left: left(to: other, offset: inset.left, priority: priority, tag: tag, active: active)
        case .right: right(to: other, offset: -inset.right, priority: priority, tag: tag, active: active)
        case .center: centerX(to: other, priority: priority, tag: tag, active: active)
        case .leading: leading(to: other, offset: inset.left, priority: priority, tag: tag, active: active)
        case .trailing: trailing(to: other, offset: -inset.right, priority: priority, tag: tag, active: active)
        }
        return self
    }
    
    /// Set the view so it fills the width of another view, with a maximum allowed width.
    /// Will constrain:
    ///     the left & right edges of the target view to the edges of `special` at `priority` - 1;
    ///     the width to be <= `maximum`
    ///     the `alignTo` edge to the same of `special`.
    @discardableResult
    public func rtlFillWidth(of special: SpecialAnchorable,
                             inset: Insets? = nil,
                             maximum: CGFloat,
                             alignTo edge: LayoutXEdge = .center,
                             priority: LayoutPriority? = nil,
                             tag: Int? = nil,
                             active: Bool? = nil) -> Layout {
        let inset = inset ?? .zero
        let priority = priority ?? LayoutPriority(rawValue: 1000)
        rtlFill(special, axis: .x, inset: inset, priority: priority - 1, tag: tag, active: active)
        width(.lessOrEqual, to: maximum, priority: priority, tag: tag, active: active)
        switch edge {
        case .left: left(to: special, offset: inset.left, priority: priority, tag: tag, active: active)
        case .right: right(to: special, offset: -inset.right, priority: priority, tag: tag, active: active)
        case .center: centerX(to: special, priority: priority, tag: tag, active: active)
        case .leading: leading(to: special, offset: inset.left, priority: priority, tag: tag, active: active)
        case .trailing: trailing(to: special, offset: -inset.right, priority: priority, tag: tag, active: active)
        }
        return self
    }
}
